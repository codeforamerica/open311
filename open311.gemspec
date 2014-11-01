lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open311/version'

Gem::Specification.new do |gem|
  gem.add_dependency 'faraday', '~> 0.7'
  gem.add_dependency 'faraday_middleware', '~> 0.7'
  gem.add_dependency 'hashie', '~> 3.3'
  gem.add_dependency 'multi_json', '~> 1.0'
  gem.add_dependency 'multi_xml', '~> 0.4'
  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.authors = ['Dan Melton', 'Erik Michaels-Ober']
  gem.description = 'A Ruby wrapper for the Open311 API v2.'
  gem.email = ['dan@codeforamerica.org', 'erik@codeforamerica.org']
  gem.files = %w(.yardopts LICENSE.md README.md open311.gemspec) + Dir['lib/**/*.rb']
  gem.homepage = 'https://github.com/codeforamerica/open311'
  gem.name = 'open311'
  gem.post_install_message = <<eos
Using this gem in your project or organization? Add it to the apps wiki!
https://github.com/codeforamerica/open311/wiki/apps
eos
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.summary = gem.description
  gem.version = Open311::VERSION
end
