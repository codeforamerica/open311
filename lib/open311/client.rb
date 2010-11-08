Dir[File.expand_path('../client/*.rb', __FILE__)].each{|file| require file}

module Open311
  class Client
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options={})
      options = Open311.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Open311::Client::Connection
    include Open311::Client::Request

    include Open311::Client::Service
  end
end
