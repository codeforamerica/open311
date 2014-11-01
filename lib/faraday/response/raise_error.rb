require 'faraday'

# @api private
module Faraday
  class Response
    class RaiseError < Response::Middleware
      def on_complete(response) # rubocop:disable CyclomaticComplexity, MethodLength
        case response[:status].to_i
        when 400
          fail Open311::BadRequest.new(error_message(response))
        when 401
          fail Open311::Unauthorized.new(error_message(response))
        when 403
          fail Open311::Forbidden.new(error_message(response))
        when 404
          fail Open311::NotFound.new(error_message(response))
        when 406
          fail Open311::NotAcceptable.new(error_message(response))
        when 500
          fail Open311::InternalServerError.new(error_message(response))
        when 502
          fail Open311::BadGateway.new(error_message(response))
        when 503
          fail Open311::ServiceUnavailable.new(error_message(response))
        end
      end

      def error_message(response)
        "#{response[:method].to_s.upcase} #{response[:url]}: #{response[:response_headers]['status']}#{(': ' + response[:body]['error']) if response[:body] && response[:body]['error']}"
      end
    end
  end
end
