require 'httparty'

class SpotifyClient
  include HTTParty
  base_uri 'api.spotify.com/v1'

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

  # Provide search category and query and return hash of result data.
  def search(category, query)
    params = parameterize(
      type: category,
      q: query
    )
    get('/search', params)
  end

  private

  def parameterize(**params)
    { query: params }
  end

  def get(endpoint, params)
    response = self.class.get(endpoint, params)
    JSON.parse(response.body)
  end
end

