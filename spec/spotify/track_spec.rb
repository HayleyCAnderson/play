require 'spec_helper'
require './lib/spotify/track'

describe Spotify::Track do
  describe '.new' do
    context 'id provided' do
      let(:id) { 'xxxxx' }

      it 'sets id to given' do
        track = described_class.new(id: id)
        expect(track.id).to eq(id)
      end
    end

    context 'id not provided' do
      it 'sets id to nil' do
        track = described_class.new
        expect(track.id).to eq(nil)
      end
    end
  end
end
