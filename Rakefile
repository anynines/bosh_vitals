require "bundler/gem_tasks"
require_relative 'lib/bosh_vitals'

task :default => :rspec

desc 'Run an irb console session'
task :console do
  require 'irb'
  require 'irb/completion'
  require 'bosh_vitals'
  ARGV.clear
  IRB.start
end

desc 'Run rspec test suite'
task :rspec do
  exec("bundle exec rspec spec/")
end

task c: :console
