# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'find_duplicates/version'

Gem::Specification.new do |spec|
  spec.name          = "find_duplicates"
  spec.version       = FindDuplicates::VERSION
  spec.authors       = ["adam klein", "500tech"]
  spec.email         = ["adam@500tech.com", "info@500tech.com"]
  spec.summary       = %q{adds methods to find duplicate rows to AR models}
  spec.description   = %q{adds methods to find duplicate rows to AR models}
  spec.homepage      = "https://github.com/500tech/find_duplicates"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activerecord', '>= 3.0'
  spec.add_runtime_dependency 'activesupport', '>= 3.0'
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

end
