require 'simplecov'
SimpleCov.start do
  add_group 'Open311', 'lib/open311'
  add_group 'Faraday', 'lib/faraday'
end

require File.expand_path('../../lib/open311', __FILE__)

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
