require 'spec_helper'
require './lib/spotify/client'

describe Spotify::Client do
  let(:artist) { 'taylor swift' }
  let(:artist_id) { '06HL4z0CvFAxyc27GXpf02' }

  describe '.search_artists' do
    it 'returns array of artist data hashes' do
      response = described_class.search_artists(artist)
      expect(response).to be_a(Array)
      expect(response.first).to be_a(Hash)
    end
  end

  describe '.get_related_artists' do
    it 'returns array of artist data hashes' do
      response = described_class.get_related_artists(artist_id)
      expect(response).to be_a(Array)
      expect(response.first).to be_a(Hash)
    end
  end

  describe '.get_top_tracks' do
    it 'returns array of track data hashes' do
      response = described_class.get_top_tracks(artist_id)
      expect(response).to be_a(Array)
      expect(response.first).to be_a(Hash)
    end
  end
end
