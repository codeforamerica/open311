require 'faraday'
require 'open311/version'

module Open311
  module Configuration
    VALID_OPTIONS_KEYS = [
      :adapter,
      :api_key,
      :endpoint,
      :format,
      :jurisdiction,
      :proxy,
      :headers,
      :user_agent].freeze

    VALID_FORMATS = [
      :json,
      :xml].freeze

    DEFAULT_ADAPTER      = Faraday.default_adapter
    DEFAULT_API_KEY      = nil
    DEFAULT_ENDPOINT     = nil
    DEFAULT_FORMAT       = :xml
    DEFAULT_JURISDICTION = nil
    DEFAULT_PROXY        = nil
    DEFAULT_HEADERS      = nil
    DEFAULT_USER_AGENT   = "Open311 Ruby Gem #{Open311::Version}".freeze

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}) { |a, e| a.merge!(e => send(e)) }
    end

    def reset
      self.adapter      = DEFAULT_ADAPTER
      self.api_key      = DEFAULT_API_KEY
      self.endpoint     = DEFAULT_ENDPOINT
      self.format       = DEFAULT_FORMAT
      self.jurisdiction = DEFAULT_JURISDICTION
      self.proxy        = DEFAULT_PROXY
      self.user_agent   = DEFAULT_USER_AGENT
      self.headers      = DEFAULT_HEADERS
    end
  end
end
