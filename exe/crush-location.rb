#!/bin/env ruby
require 'ceph/crush/location'

Ceph::Crush::Location::Options::Parser.parse

puts Ceph::Crush::Location.options
