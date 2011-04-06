require 'faraday'

# @api private
module Faraday
  class Response::RaiseError < Response::Middleware
    def on_complete(response)
      case response[:status].to_i
      when 400
        raise Open311::BadRequest, error_message(response)
      when 401
        raise Open311::Unauthorized, error_message(response)
      when 403
        raise Open311::Forbidden, error_message(response)
      when 404
        raise Open311::NotFound, error_message(response)
      when 406
        raise Open311::NotAcceptable, error_message(response)
      when 500
        raise Open311::InternalServerError, error_message(response)
      when 502
        raise Open311::BadGateway, error_message(response)
      when 503
        raise Open311::ServiceUnavailable, error_message(response)
      end
    end

    def error_message(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:response_headers]['status']}#{(': ' + response[:body]['error']) if response[:body] && response[:body]['error']}"
    end
  end
end
