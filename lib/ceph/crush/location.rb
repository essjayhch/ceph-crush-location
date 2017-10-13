# Ruby module for code to do with Ceph
module Ceph
  # Ruby Module to do with Crush Maps
  module Crush
    # Code to handle where to inject OSDs into the Crush Map
    module Location
      require 'rubygems'
      require 'active_support'
      mattr_accessor :nodeinfo, :logger, :options
      require 'ceph/crush/location/version'
      require 'ceph/crush/location/logger'
      Ceph::Crush::Location::Logger.send('Load')
      require 'ceph/crush/location/options/parser'
      require 'ceph/crush/location/node_info/parser'
      require 'ceph/crush/location/osd'
      require 'ceph/crush/location/bucket'
      Ceph::Crush::Location::Logger.send('Loaded')
    end
  end
end
