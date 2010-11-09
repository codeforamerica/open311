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
