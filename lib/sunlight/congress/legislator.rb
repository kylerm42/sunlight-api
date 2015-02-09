require 'geocoder'

module Sunlight
  class Congress
    class Legislator

      SEARCH_ATTRIBUTES = [:first_name, :middle_name, :last_name, :name_suffix,
                          :nickname, :state, :state_name, :state_rank, :party,
                          :chamber, :title, :senate_class, :district, :term_start,
                          :term_end, :birthday, :fax, :in_office, :bioguide_id,
                          :crp_id, :govtrack_id, :icpsr_id, :fec_ids, :lis_id,
                          :ocd_id, :thomas_id, :votesmart_id, :oc_email]

      attr_accessor *SEARCH_ATTRIBUTES.concat([:phone, :website, :office, :contact_form,
                                              :fax, :twitter_id, :youtube_id, :facebook_id])

      def initialize(options = {})
        options.each do |attribute, value|
          instance_variable_set("@#{attribute}", value)
        end
      end

      class << self
        def locate_by_zip(zip)
          response = Net::HTTP.get_response(locate_uri(zip: zip))

          JSON.parse(response.body)['results'].map do |legislator_attrs|
            self.new(legislator_attrs)
          end
        end

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

        def find(query)
          if query.is_a?(String)
            response = Net::HTTP.get_response(find_uri(query: query))
          else
            response = Net::HTTP.get_response(find_uri(query))
          end

          create_from_response(response)
        end

        SEARCH_ATTRIBUTES.each do |param|
          define_method("find_by_#{param}") do |query|
            response = Net::HTTP.get_response(find_uri("#{param}" => query))

            create_from_response(response)
          end
        end

        def find_uri(options = {})
          encode_uri('legislators', options)
        end

        def encode_uri(location, options)
          uri = URI("#{BASE_URI}/#{location}")
          uri.query = URI.encode_www_form(options.merge(apikey: '6d4acf5a753c40e1824857bb12679d89'))

          uri
        end

        def create_from_response(response)
          json = JSON.parse(response.body)

          if results = json['results']
            results.map do |legislator_attrs|
              self.new(legislator_attrs)
            end
          elsif errors = json['error']
            json
          end
        end
      end
    end
  end
end
