require 'spec_helper'
require './lib/spotify/artist'

describe Spotify::Artist do
  let(:artist_name) { 'taylor swift' }
  let(:artist_id) { '06HL4z0CvFAxyc27GXpf02' }

  describe '.new' do
    context 'with id' do
      it 'sets id to id given' do
        artist = described_class.new(id: artist_id)
        expect(artist.id).to eq(artist_id)
      end

      it 'does not call client' do
        expect(Spotify::Client).to_not receive(:search_artists)
        described_class.new(id: artist_id)
      end
    end

    context 'with name' do
      context 'artist id found' do
        let(:artists) do
          [
            {
              'name' => artist_name,
              'id' => artist_id
            },
            {
              'name' => "#{artist_name} tribute band",
              'id' => 'xxxxx'
            }
          ]
        end

        it 'sets id to id returned by client' do
          expect(Spotify::Client)
            .to receive(:search_artists)
            .with(artist_name)
            .and_return(artists)

          artist = described_class.new(name: artist_name)
          expect(artist.id).to eq(artist_id)
        end
      end

      context 'artist id not found' do
        it 'raises invalid artist error' do
          expect(Spotify::Client)
            .to receive(:search_artists)
            .with(artist_name)
            .and_return([])

          expect{ described_class.new(name: artist_name) }
            .to raise_error(Exceptions::InvalidArtist)
        end
      end
    end

    context 'with id and name' do
      it 'sets id to id given' do
        artist = described_class.new(id: artist_id, name: artist_name)
        expect(artist.id).to eq(artist_id)
      end

      it 'does not call client' do
        expect(Spotify::Client).to_not receive(:search_artists)
        described_class.new(id: artist_id, name: artist_name)
      end
    end

    context 'with neither id nor name' do
      it 'raises invalid artist error' do
        expect{ described_class.new }
          .to raise_error(Exceptions::InvalidArtist)
      end
    end
  end

  describe '#related_artists' do
    let(:artist) { described_class.new(id: artist_id) }

    context 'valid and invalid results' do
      let(:related_id) { 'xxxxx' }
      let(:results) { [{'id' => related_id}, {}] }
      let(:related_artist) { Spotify::Artist.new(id: related_id) }

      before do
        expect(Spotify::Client)
          .to receive(:get_related_artists)
          .with(artist_id)
          .and_return(results)
        expect(Spotify::ObjectBuilder)
          .to receive(:build_from_list)
          .with(results, Spotify::Artist)
          .and_return([related_artist])
      end

      it 'returns array of valid artist instances' do
        related_artists = artist.related_artists
        expect(related_artists).to eq([related_artist])
      end
    end

    context 'no results' do
      let(:results) { [] }

      before do
        expect(Spotify::Client)
          .to receive(:get_related_artists)
          .with(artist_id)
          .and_return(results)
        expect(Spotify::ObjectBuilder)
          .to receive(:build_from_list)
          .with(results, Spotify::Artist)
          .and_return([])
      end

      it 'returns empty array' do
        related_artists = artist.related_artists
        expect(related_artists).to eq([])
      end
    end
  end

  describe '#top_tracks' do
    let(:artist) { described_class.new(id: artist_id) }

    context 'valid and invalid results' do
      let(:related_id) { 'xxxxx' }
      let(:results) { [{'id' => related_id}, {}] }
      let(:top_track) { Spotify::Track.new(id: related_id) }

      before do
        expect(Spotify::Client)
          .to receive(:get_top_tracks)
          .with(artist_id)
          .and_return(results)
        expect(Spotify::ObjectBuilder)
          .to receive(:build_from_list)
          .with(results, Spotify::Track)
          .and_return([top_track])
      end

      it 'returns array of valid track instances' do
        top_tracks = artist.top_tracks
        expect(top_tracks).to eq([top_track])
      end
    end

    context 'no results' do
      let(:results) { [] }

      before do
        expect(Spotify::Client)
          .to receive(:get_top_tracks)
          .with(artist_id)
          .and_return(results)
        expect(Spotify::ObjectBuilder)
          .to receive(:build_from_list)
          .with(results, Spotify::Track)
          .and_return([])
      end

      it 'returns empty array' do
        top_tracks = artist.top_tracks
        expect(top_tracks).to eq([])
      end
    end
  end
end
