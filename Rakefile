require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test => :spec

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  task :rubocop do
    $stderr.puts 'Rubocop is disabled'
  end
end

namespace :doc do
  require 'yard'
  YARD::Rake::YardocTask.new do |task|
    task.files   = ['LICENSE.md', 'lib/**/*.rb']
    task.options = [
      '--no-private',
      '--protected',
      '--output-dir', 'doc/yard',
      '--tag', 'format:Supported formats',
      '--tag', 'key:Requires API key',
      '--markup', 'markdown'
    ]
  end
end

task :default => [:spec, :rubocop]
