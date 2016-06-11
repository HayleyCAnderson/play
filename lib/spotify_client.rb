require 'httparty'

class SpotifyClient
  include HTTParty
  base_uri 'api.spotify.com/v1'

  def initialize
    @country = 'US'
  end

  # Provide artist name string and return top matching artist id string.
  def find_artist_id(query)
    artists = search_artists(query)
    artists.first['id']
  end

  # Provide artist name string and return array of matching artist data.
  def search_artists(query)
    response = search('artist', query)
    response['artists']['items']
  end

  # Provide artist name string and return array of related artist ids.
  def find_related_artist_ids(query)
    artist_id = find_artist_id(query)
    artists = get_related_artists(artist_id)
    artists.map { |artist| artist['id'] }
  end

  # Provide artist id string and return array of related artist data.
  def get_related_artists(artist_id)
    response = get("/artists/#{artist_id}/related-artists")
    response['artists']
  end

  # Provide artist id string and return array of top tracks data.
  def get_top_tracks(artist_id)
    params = parameterize(country: @country)
    response = get("/artists/#{artist_id}/top-tracks", params)
    response['tracks']
  end

  private

  def search(category, query)
    params = parameterize(
      type: category,
      q: query
    )
    get('/search', params)
  end

  def parameterize(**params)
    { query: params }
  end

  def get(endpoint, params={})
    response = self.class.get(endpoint, params)
    JSON.parse(response.body)
  end
end

