require 'faraday_middleware'
require 'open311/response/raise_error'

module Open311
  class Client
    # @private
    module Connection
    private

      def options
        {
          # :headers => {'Accept' => "*/#{format}", 'User-Agent' => user_agent},
          proxy: proxy,
          ssl: {verify: false},
          url: endpoint,
          headers: headers,
        }
      end

      def connection
        Faraday.new(options) do |connection|
          connection.use Faraday::Request::Multipart
          connection.use Faraday::Response::Mashify
          case format.to_s.downcase
          when 'json' then connection.use Faraday::Response::ParseJson
          when 'xml' then connection.use Faraday::Response::ParseXml
          end
          connection.use Open311::Response::RaiseError
          connection.adapter(adapter)
        end
      end
    end
  end
end
