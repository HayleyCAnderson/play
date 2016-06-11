require 'spec_helper'
require './lib/spotify_client'

describe SpotifyClient do
  describe '#find_artist_id' do
    let(:client) { described_class.new }
    let(:query) { 'taylor swift' }

    it 'returns top artist id' do
      response = client.find_artist_id(query)
      expect(response).to eq('06HL4z0CvFAxyc27GXpf02')
    end
  end

  describe '#search_artists' do
    let(:client) { described_class.new }
    let(:query) { 'taylor swift' }

    it 'returns array of artists' do
      response = client.search_artists(query)
      expect(response).to be_a(Array)
    end
  end

  describe '#search' do
    let(:client) { described_class.new }
    let(:type) { 'artist' }
    let(:query) { 'taylor swift' }

    it 'returns a hash with artists' do
      response = client.search(type, query)
      expect(response).to be_a(Hash)
      expect(response['artists']).to be_a(Hash)
      expect(response['artists']['items']).to be_a(Array)
    end
  end
end

