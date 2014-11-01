lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open311/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'faraday', '~> 0.7'
  spec.add_dependency 'faraday_middleware', '~> 0.7'
  spec.add_dependency 'hashie', '~> 3.3'
  spec.add_dependency 'multi_json', '~> 1.0'
  spec.add_dependency 'multi_xml', '~> 0.4'
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.authors = ['Dan Melton', 'Erik Michaels-Ober']
  spec.description = 'A Ruby wrapper for the Open311 API v2.'
  spec.email = ['dan@codeforamerica.org', 'erik@codeforamerica.org']
  spec.files = %w(.yardopts CONTRIBUTING.md LICENSE.md README.md open311.gemspec) + Dir['lib/**/*.rb']
  spec.homepage = 'https://github.com/codeforamerica/open311'
  spec.name = 'open311'
  spec.post_install_message = <<eos
Using this gem in your project or organization? Add it to the apps wiki!
https://github.com/codeforamerica/open311/wiki/apps
eos
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 1.9.3'
  spec.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  spec.summary = spec.description
  spec.version = Open311::VERSION
end
