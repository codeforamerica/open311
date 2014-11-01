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
          :proxy => proxy,
          :ssl => {:verify => false},
          :url => endpoint,
        }
      end

      def connection(raw = false)
        Faraday.new(options) do |connection|
          connection.use Faraday::Request::Multipart
          unless raw
            connection.use Faraday::Response::Mashify
            case format.to_s.downcase
            when 'json'
              connection.use Faraday::Response::ParseJson
            when 'xml'
              connection.use Faraday::Response::ParseXml
            end
          end
          connection.use Open311::Response::RaiseError
          connection.adapter(adapter)
        end
      end
    end
  end
end
