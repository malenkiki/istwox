# -*- encoding: utf-8 -*-

require "istwox"

include_files = ["README", "LICENSE", "INSTALL", "Changelog", "init.rb", "{lib,spec,doc}/**/*"].map do |glob|
  Dir[glob]
end.flatten

$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

Gem::Specification.new do |s|
  s.name = "istwox"
  s.version = Istwox::VERSION
  s.authors = ["Michel Petit"]
  s.email = "petit.michel@gmail.com"
  s.files = include_files
  s.require_path = "lib"
  s.summary = ""

end
