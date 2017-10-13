# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ceph/crush/location/version'

Gem::Specification.new do |spec|
  spec.name          = 'ceph-crush-location'
  spec.version       = Ceph::Crush::Location::VERSION
  spec.authors       = ['Stuart Harland']
  spec.email         = ['s.harland@livelinktechnology.net']

  spec.summary       = 'Manage where OSDs are found in crush map'
  spec.homepage      = 'https://github.com/essjayhch/ceph-crush-location'
  spec.licenses      = ['MIT']
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'json'
  spec.add_runtime_dependency 'logger'
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
