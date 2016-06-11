require 'spec_helper'
require './lib/spotify_client'

describe SpotifyClient do
  let(:client) { described_class.new }
  let(:artist) { 'taylor swift' }
  let(:artist_id) { '06HL4z0CvFAxyc27GXpf02' }

  describe '#find_artist_id' do
    it 'returns top artist id' do
      response = client.find_artist_id(artist)
      expect(response).to eq(artist_id)
    end
  end

  describe '#search_artists' do
    it 'returns array of artist data hashes' do
      response = client.search_artists(artist)
      expect(response).to be_a(Array)
      expect(response.first).to be_a(Hash)
    end
  end

  describe '#get_related_artists' do
    it 'returns array of artist data hashes' do
      response = client.get_related_artists(artist_id)
      expect(response).to be_a(Array)
      expect(response.first).to be_a(Hash)
    end
  end

  describe '#find_related_artist_ids' do
    it 'returns array of artist ids' do
      response = client.find_related_artist_ids(artist)
      expect(response).to be_a(Array)
      expect(response.first).to be_a(String)
    end
  end

  describe '#get_top_tracks' do
    it 'returns array of track data hashes' do
      response = client.get_top_tracks(artist_id)
      expect(response).to be_a(Array)
      expect(response.first).to be_a(Hash)
    end
  end
end

