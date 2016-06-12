module Spotify
  class Track
    attr_reader :id

    def initialize(id: nil)
      @id = id
    end
  end
end
