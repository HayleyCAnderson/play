module Spotify
  class ObjectBuilder
    def self.build_from_list(data_list, klass)
      objects = []
      data_list.each do |item|
        if item['id']
          objects << klass.new(id: item['id'])
        end
      end
      objects
    end
  end
end
