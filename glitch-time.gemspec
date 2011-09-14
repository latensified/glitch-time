# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "glitch-time/version"

Gem::Specification.new do |s|
  s.name        = "glitch-time"
  s.version     = "0.0.3"
  s.authors     = ["Simon Peck"]
  s.email       =   ""
  s.homepage    = ""
  s.summary     = %q{This is a port of the Glitch time converter.}
  s.description = %q{The glitch time and date specification is here: http://api.glitch.com/docs/time/}

  s.rubyforge_project = "glitch-time"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
