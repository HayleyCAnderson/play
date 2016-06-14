require 'exceptions'
require 'spotify/object_builder'

module Spotify
  class Artist
    attr_reader :id

    def initialize(id: nil, name: nil)
      @id = id || get_id(name)
    end

    def related_artists
      @related_artists ||= get_related_artists
    end

    def top_tracks
      @top_tracks ||= get_top_tracks
    end

    private

    def get_id(name)
      raise Exceptions::InvalidArtist.new('Must set either id or name.') unless name
      artist = Client.search_artists(name).first || {}
      artist_id = artist['id']
      raise Exceptions::InvalidArtist.new('Could not find artist id.') unless artist_id
      artist_id
    end

    def get_related_artists
      artists = Client.get_related_artists(id)
      ObjectBuilder.build_from_list(artists, Artist)
    end

    def get_top_tracks
      tracks = Client.get_top_tracks(id)
      ObjectBuilder.build_from_list(tracks, Track)
    end
  end
end
