# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "glitch-time/version"

Gem::Specification.new do |s|
  s.name        = "glitch-time"
  s.version     = Glitch::Time::VERSION
  s.authors     = ["Simon Peck"]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = %q{This is a port of the Glitch time converter.}
  s.description = %q{The glitch time and date specification is here: http://api.glitch.com/docs/time/}

  s.rubyforge_project = "glitch-time"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
