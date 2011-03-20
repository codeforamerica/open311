require 'simplecov'
SimpleCov.start do
  add_group 'Open311', 'lib/open311'
  add_group 'Faraday', 'lib/faraday'
end
require 'open311'
require 'rspec'
require 'webmock/rspec'
RSpec.configure do |config|
  config.include WebMock::API
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
