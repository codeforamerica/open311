source 'https://rubygems.org'

gem 'maruku'
gem 'rake'
gem 'yard'

group :test do
  gem 'backports'
  gem 'rspec'
  gem 'rubocop', '>= 0.27'
  gem 'simplecov'
  gem 'webmock'
  gem 'yardstick'
end

platforms :jruby do
  gem 'jruby-openssl', '~> 0.7'
end

# Specify your gem's dependencies in open311.gemspec
gemspec
