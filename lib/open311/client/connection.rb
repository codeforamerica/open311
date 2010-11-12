require 'faraday_middleware'
Dir[File.expand_path('../../../faraday/*.rb', __FILE__)].each{|file| require file}

module Open311
  class Client
    # @private
    module Connection
      private

      def connection(raw=false)
        options = {
          # :headers => {'Accept' => "*/#{format}", 'User-Agent' => user_agent},
          :proxy => proxy,
          :ssl => {:verify => false},
          :url => endpoint
        }

        Faraday::Connection.new(options) do |connection|
          connection.use Faraday::Request::Multipart
          connection.adapter(adapter)
          connection.use Faraday::Response::RaiseError
          unless raw
            case format.to_s.downcase
            when 'json' then connection.use Faraday::Response::ParseJson
            when 'xml' then connection.use Faraday::Response::ParseXml
            end
            connection.use Faraday::Response::Mashify
            #connection.use Faraday::Response::ConvertValues
          end
        end
      end
    end
  end
end
