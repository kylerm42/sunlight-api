# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sunlight/version'

Gem::Specification.new do |spec|
  spec.name          = "sunlight-api"
  spec.version       = Sunlight::VERSION
  spec.authors       = ["Kyle Moore"]
  spec.email         = ["kylerm42code@gmail.com"]
  spec.summary       = %q{Gem for interacting with various Sunlight Foundation APIs}
  spec.homepage      = "https://github.com/kylerm42/sunlight-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency 'geocoder'
end
