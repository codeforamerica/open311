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

        Faraday::Connection.new(options) do |builder|
          builder.use Faraday::Request::Multipart
          builder.adapter(adapter)
          builder.use Faraday::Response::RaiseError
          builder.use Faraday::Response::Parse unless raw
          builder.use Faraday::Response::Mashify unless raw
        end
      end
    end
  end
end
