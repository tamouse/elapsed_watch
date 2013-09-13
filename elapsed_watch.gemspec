# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elapsed_watch/version'

Gem::Specification.new do |spec|
  spec.name          = "elapsed_watch"
  spec.version       = ElapsedWatch::VERSION
  spec.authors       = ["Tamara Temple"]
  spec.email         = ["tamouse@gmail.com"]
  spec.description   = ElapsedWatch::DESCRIPTION
  spec.summary       = ElapsedWatch::SUMMARY
  spec.homepage      = "http://github.com/tamouse/elapsed_watch"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency('rdoc')
  spec.add_development_dependency('aruba')
  spec.add_development_dependency('rake', '~> 0.9.2')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('timecop')
  
  spec.add_dependency('methadone', '~> 1.3.0')
  spec.add_dependency('chronic_duration')
  
end
