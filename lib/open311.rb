require 'open311/configuration'
require 'open311/client'
require 'open311/error'

module Open311
  extend Configuration
  class << self
    # Alias for Open311::Client.new
    #
    # @return [Open311::Client]
    def new(options = {})
      Open311::Client.new(options)
    end

    # Delegate to Open311::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
