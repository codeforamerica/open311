if RUBY_VERSION >= '1.9'
  require 'simplecov'

  SimpleCov.start do
    add_filter '/spec/'
    minimum_coverage(97.44)
  end
end

require 'open311'
require 'rspec'
require 'webmock/rspec'

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
