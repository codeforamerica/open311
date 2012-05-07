# encoding: utf-8
require File.expand_path('../lib/open311/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'faraday', '~> 0.7'
  gem.add_dependency 'faraday_middleware', '~> 0.7'
  gem.add_dependency 'hashie', '~> 1.2'
  gem.add_dependency 'multi_json', '~> 1.0'
  gem.add_dependency 'multi_xml', '~> 0.4'
  gem.add_development_dependency 'maruku'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'yard'
  gem.authors = ["Dan Melton", "Erik Michaels-Ober"]
  gem.description = %q{A Ruby wrapper for the Open311 API v2.}
  gem.email = ['dan@codeforamerica.org', 'erik@codeforamerica.org']
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'https://github.com/codeforamerica/open311'
  gem.name = 'open311'
  gem.post_install_message =<<eos
Using this gem in your project or organization? Add it to the apps wiki!
https://github.com/codeforamerica/open311/wiki/apps
eos
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.summary = gem.description
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = Open311::VERSION
end
