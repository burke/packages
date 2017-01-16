# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'packages/version'

Gem::Specification.new do |spec|
  spec.name          = "packages"
  spec.version       = Packages::VERSION
  spec.authors       = ["Burke Libbey"]
  spec.email         = ["burke@libbey.me"]

  spec.summary       = %q{proof-of-concept package system for ruby}
  spec.description   = %q{proof-of-concept package system for ruby using an experimental unmerged MRI feature}
  spec.homepage      = "https://github.com/burke/packages"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
