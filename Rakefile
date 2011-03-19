require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'yard'
require 'rake/gempackagetask'
require 'rspec/core/rake_task'

desc 'Test the librairy'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ['--color', "--format progress"]
  t.pattern = 'spec/*_spec.rb'
end

# See https://github.com/burtlo/YARD-Tutorial/wiki/Yard-parser to have more information
YARD::Rake::YardocTask.new do |t|
  t.options = ['--protected','--private', '--readme', 'README.rdoc']
end

desc 'generate gem file'
eval("$specification = begin; #{IO.read('istwox.gemspec')}; end")
Rake::GemPackageTask.new($specification) do |package|
  package.need_zip = true
  package.need_tar = true
end

