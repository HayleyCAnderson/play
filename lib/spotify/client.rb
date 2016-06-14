require 'httparty'

module Spotify
  class Client
    include HTTParty
    base_uri 'api.spotify.com/v1'
    COUNTRY = 'US'

    class << self
      # Provide artist name string and return array of matching artist data.
      def search_artists(query)
        response = search('artist', query)
        artists = response['artists'] || {}
        artists['items'] || []
      end

      # Provide artist id string and return array of related artist data.
      def get_related_artists(artist_id)
        response = get_and_parse("/artists/#{artist_id}/related-artists")
        response['artists'] || []
      end

      # Provide artist id string and return array of top tracks data.
      def get_top_tracks(artist_id)
        params = {country: COUNTRY}
        response = get_and_parse("/artists/#{artist_id}/top-tracks", params)
        response['tracks'] || []
      end

      private

      def search(category, query)
        params = {type: category, q: query}
        get_and_parse('/search', params)
      end

      def get_and_parse(endpoint, params={})
        response = get(endpoint, { query: params })
        JSON.parse(response.body)
      end
    end
  end
end
