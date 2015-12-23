# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bosh_vitals/version'

Gem::Specification.new do |spec|
  spec.name          = "bosh_vitals"
  spec.version       = BoshVitals::VERSION
  spec.authors       = ["Julian Weber"]
  spec.email         = ["jweber@anynines.com"]
  spec.summary       = %q{bosh_vitals is a library to acces bosh vitals information from a BOSH director and perform custom health checks on it.}
  spec.description   = %q{bosh_vitals is a library to acces bosh vitals information from a BOSH director and perform custom health checks on it.}
  spec.homepage      = "http://www.github.com/anynines/bosh_vitals"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_dependency "httparty"
  spec.add_dependency "bosh_cli", "~> 1.2915.0"
end
