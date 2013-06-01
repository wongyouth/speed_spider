# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'speed_spider/version'

Gem::Specification.new do |spec|
  spec.name          = "speed_spider"
  spec.version       = SpeedSpider::VERSION
  spec.authors       = ["Ryan Wang"]
  spec.email         = ["wongyouth@gmail.com"]
  spec.description   = %q{A simple web spider tool for crawling pages to local based on a url}
  spec.summary       = %q{A simple web spider tool for download pages from a base url including css js html and iframe source files}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "anemone", "~> 0.7.2"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
