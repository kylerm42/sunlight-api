module Sunlight
  class Congress
    class District < CongressApi

      attr_accessor :state, :district

      def initialize(options = {})
        options.each do |attribute, value|
          instance_variable_set("@#{attribute}", value)
        end
      end

      class << self
        def locate(options)
          if options.is_a?(String) || options[:address]
            coords = Geocoder.coordinates(options)
            response = Net::HTTP.get_response(locate_uri(latitude: coords[0], longitude: coords[1]))
          else
            response = Net::HTTP.get_response(locate_uri(options))
          end

          create_from_response(response)
        end

        def locate_uri(options = {})
          encode_uri('legislators/locate', options)
        end
      end
    end
  end
end
