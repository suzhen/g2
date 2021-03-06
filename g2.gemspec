# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'g2/version'

Gem::Specification.new do |spec|
  spec.name          = "g2"
  spec.version       = G2::VERSION
  spec.authors       = ["lizhe"]
  spec.email         = ["me@lizhe.name"]
  spec.description   = %q{a tool to help you to manage goliath grape based application}
  spec.summary       = %q{rock with goliath and grape}
  spec.homepage      = "https://github.com/markee/g2"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "bundler", "~> 1.3"
  spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "rake"
  spec.add_runtime_dependency "pry"
  spec.add_runtime_dependency "awesome_print"
end
