module Open311
  class ServiceRequest
    attr_reader :token, :id

    def initialize(hash)
      @hash = hash
      @id = hash.service_request_id.to_i
      @token = hash.token.to_i
    end

    # Delegate to the hash
    def self.method_missing(method, *args, &block)
      return super unless @hash.has_key?(method)
      @hash[method]
    end
  end
end
