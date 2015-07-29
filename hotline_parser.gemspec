# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hotline_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "hotline_parser"
  spec.version       = HotlineParser::VERSION
  spec.authors       = ["salf"]
  spec.email         = ["nikola.symonov@gmail.com"]
  spec.summary       = "HotlineParser"
  spec.description   = "Tool for parsing products page from hotline.ua"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($\)
  spec.executables   = ['hoter']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'typhoeus', '~> 0.7.2'
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
