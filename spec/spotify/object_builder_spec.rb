require 'spec_helper'
require './lib/spotify/object_builder'

describe Spotify::ObjectBuilder do
  let(:test_object) { double('TestObject') }
  let(:test_item) { instance_double('TestObject') }

  describe '.build_from_list' do
    context 'empty data' do
      let(:data) { [] }

      it 'returns an empty array' do
        objects = described_class.build_from_list(data, test_object)
        expect(objects).to eq([])
      end
    end

    context 'valid and invalid data' do
      let(:data) do
        [
          {'id' => 'xxxxx'},
          {'something' => 'not an id'},
          {},
          {'id' => 'yyyyy'}
        ]
      end

      it 'create new objects for valid items and return array' do
        expect(test_object).to receive(:new).with(id: 'xxxxx').and_return(test_item)
        expect(test_object).to receive(:new).with(id: 'yyyyy').and_return(test_item)

        objects = described_class.build_from_list(data, test_object)

        expect(objects).to be_a(Array)
        expect(objects[0]).to eq(test_item)
        expect(objects[1]).to eq(test_item)
      end
    end
  end
end
