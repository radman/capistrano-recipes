# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano-recipes/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-recipes"
  spec.version       = CapistranoRecipes::VERSION
  spec.authors       = ["Radu Vlad"]
  spec.email         = ["radu.a.vlad@gmail.com"]
  spec.description   = %q{My capistrano recipes}
  spec.summary       = %q{My capistrano recipes}

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "capistrano"
  spec.add_dependency "unicorn"
end
