require File.expand_path('../open311/configuration', __FILE__)
require File.expand_path('../open311/client', __FILE__)
require File.expand_path('../open311/service_request', __FILE__)

module Open311
  extend Configuration

  # Alias for Open311::Client.new
  #
  # @return [Open311::Client]
  def self.client(options={})
    Open311::Client.new(options)
  end

  # Delegate to Open311::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Custom error class for rescuing from all Open311 errors
  class Error < StandardError; end

  # Raised when Open311 returns a 400 HTTP status code
  class BadRequest < Error; end

  # Raised when Open311 returns a 401 HTTP status code
  class Unauthorized < Error; end

  # Raised when Open311 returns a 403 HTTP status code
  class Forbidden < Error; end

  # Raised when Open311 returns a 404 HTTP status code
  class NotFound < Error; end

  # Raised when Open311 returns a 406 HTTP status code
  class NotAcceptable < Error; end

  # Raised when Open311 returns a 500 HTTP status code
  class InternalServerError < Error; end

  # Raised when Open311 returns a 502 HTTP status code
  class BadGateway < Error; end

  # Raised when Open311 returns a 503 HTTP status code
  class ServiceUnavailable < Error; end
end
