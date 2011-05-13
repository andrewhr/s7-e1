# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "process_status/version"

Gem::Specification.new do |s|
  s.name        = "process_status"
  s.version     = ProcessStatus::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrew Rosa"]
  s.email       = ["andrewhr@me.com"]
  s.homepage    = ""
  s.summary     = %q{ps command wrapper}
  s.description = %q{Library that wrap the ps command and print some nice graphs}

  s.rubyforge_project = "process_status"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 2.6.0'
end
