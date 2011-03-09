require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rspec/core/rake_task'

desc 'Test the librairy'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ['--color', "--format progress"]
  t.pattern = 'spec/*_spec.rb'
end

desc 'Generate API documentation to doc/index.html'
Rake::RDocTask.new do |rd|
  rd.rdoc_dir = 'doc'
  rd.main = 'README'
  rd.rdoc_files.include 'README', "lib/**/*\.rb" 
 
  rd.options << '--all'
end

desc 'generate gem file'
eval("$specification = begin; #{IO.read('istwox.gemspec')}; end")
Rake::GemPackageTask.new($specification) do |package|
  package.need_zip = true
  package.need_tar = true
end

