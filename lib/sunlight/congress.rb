require 'net/http'

module Sunlight
  class Congress
    BASE_URI = 'https://congress.api.sunlightfoundation.com'

    class CongressApi
      class << self
        def encode_uri(location, options)
          uri = URI("#{BASE_URI}/#{location}")
          uri.query = URI.encode_www_form(options.merge(apikey: '6d4acf5a753c40e1824857bb12679d89'))

          uri
        end

        def create_from_response(response)
          json = JSON.parse(response.body)

          if results = json['results']
            results.map do |attributes|
              self.new(attributes)
            end
          else
            json
          end
        end

      end
    end
  end
end
