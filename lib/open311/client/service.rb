module Open311
  class Client
    module Service
      # Provide a list of acceptable 311 service request types and their associated service codes
      #
      # @format :xml
      # @key false
      # @param options [Hash] A customizable set of options.
      # @return [Array]
      # @see http://wiki.open311.org/GeoReport_v2#GET_Service_List
      # @example Provide a list of acceptable 311 service request types and their associated service codes
      #   Open311.service_list
      def service_list(options={})
        options.merge!(:jurisdiction_id => jurisdiction, :lat => lat, :long => long)
        response = get('services', options)
        format.to_s.downcase == 'xml' ? response['services']['service'] : response
      end

      # @format :xml
      # @key false
      # @param id String the service code 
      # @param options [Hash] A customizable set of options.
      # @return Hash
      # @see http://wiki.open311.org/GeoReport_v2#GET_Service_Definition
      # @example define attributes associated with a service code, i.e. 033
      #   Open311.service_definition     
      def service_definition(id, options={})
        options.merge!(:jurisdiction_id => jurisdiction, :lat => lat, :long => long)
        response = get("services/#{id}", options)
        format.to_s.downcase == 'xml' ? response['service_definition'] : response        
      end
      
      # @format :xml
      # @key false
      # @param options [Hash] A customizable set of options.
      # @return [Array]
      # @see http://wiki.open311.org/GeoReport_v2#GET_Service_Requests
      #   Open311.service_requests           
      def service_requests(options={})
        options.merge!(:jurisdiction_id => jurisdiction, :lat => lat, :long => long)
        response = get("requests", options)
        format.to_s.downcase == 'xml' ? response['service_requests']['request'] : response        
      end
      
      # @format :xml
      # @key false
      # @param id String of the service request id 
      # @param options [Hash] A customizable set of options.
      # @return Hash
      # @see http://wiki.open311.org/GeoReport_v2#GET_Service_Requests
      #   Open311.get_service_request
      def get_service_request(id, options={})
        options.merge!(:jurisdiction_id => jurisdiction, :lat => lat, :long => long)
        response = get("requests/#{id}", options)
        format.to_s.downcase == 'xml' ? response['service_requests']['request'] : response        
      end
      
    end
  end
end
