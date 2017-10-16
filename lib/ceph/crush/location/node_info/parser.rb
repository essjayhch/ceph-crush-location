module Ceph
  module Crush
    module Location
      # This Module loads information about this node from a json file
      module NodeInfo
        def self.load
          Ceph::Crush::Location::Logger.send('loading node info')
          require 'json'
          Ceph::Crush::Location.nodeinfo = JSON.parse(
            ::File.read(Ceph::Crush::Location.options[:nodeinfo])
          )
        rescue
          Ceph::Crush::Location.nodeinfo = {}
        end
      end
    end
  end
end
Ceph::Crush::Location::NodeInfo.load
