require 'socket'
module Ceph
  module Crush
    module Location
      # This class stores metadata about this OSD
      class OSD
        attr_accessor :id, :cluster
        CEPH_OSD_ROOT_PATH = '/var/lib/ceph/osd'.freeze
        def initialize
          Ceph::Crush::Location::Logger.send('OSD.initialize')
          self.id = Ceph::Crush::Location.options[:id]
          self.cluster = Ceph::Crush::Location.options[:cluster]
        end

        def osd_directory
          Ceph::Crush::Location::Logger.send('OSD.osd_directory')
          ::File.join CEPH_OSD_ROOT_PATH, "#{cluster}-#{id}"
        end

        def default_root?
          !::File.exist? root_path
        end

        def root_path
          @root_path ||= ::File.join(osd_directory, 'crush_root')
        end

        def root
          return 'default' if default_root?
          ::File.read root_path
        end

        def disk_chassis_path
          Ceph::Crush::Location::Logger.send('OSD.disk_chassis_path')
          @disk_chassis_path ||= ::File.join(osd_directory, 'disk_chassis')
        end

        def knows_disk_chassis?
          ::File.exist? disk_chassis_path
        end

        def disk_chassis
          ::File.read disk_chassis_path if knows_disk_chassis?
        end

        def enclosure_path
          Ceph::Crush::Location::Logger.send('OSD.enclosure_path')
          @enclosure_path ||= ::File.join(osd_directory, 'enclosure')
        end

        def knows_enclosure?
          ::File.exist? enclosure_path
        end

        def enclosure
          ::File.read enclosure_path if knows_enclosure?
        end

        def knows_chassis?
          !chassis.nil?
        end

        def chassis
          Ceph::Crush::Location::Logger.send('OSD.chassis')
          @chassis ||= Ceph::Crush::Location.nodeinfo['chassis']
        end

        def knows_rack?
          !rack.nil?
        end

        def rack
          @rack ||= Ceph::Crush::Location.nodeinfo['rack']
        end

        def knows_row?
          !row.nil?
        end

        def row
          @row ||= Ceph::Crush::Location.nodeinfo['row']
        end

        def knows_datacenter?
          !datacenter.nil?
        end

        def datacenter
          Ceph::Crush::Location::Logger.send('OSD.datacenter')
          @datacenter ||= Ceph::Crush::Location.nodeinfo['datacenter']
        end

        def hostname
          Socket.gethostname.strip.split('.').first
        end

        def root_artifact(append = '')
          "#{root}_#{append}"
        end

        def datacenter_artifact(append = '')
          return root_artifact("#{datacenter}_#{append}") if knows_datacenter?
          root_artifact(append)
        end

        def row_artifact(append = '')
          return datacenter_artifact("#{row}_#{append}") if knows_row?
          datacenter_artifact(append)
        end

        def rack_artifact(append = '')
          return row_artifact("#{rack}_#{append}") if knows_rack?
          row_artifact(append)
        end

        def chassis_artifact(append = '')
          return rack_artifact("#{chassis}_#{append}") if knows_chassis?
          rack_artifact(append)
        end

        def host_artifact(append = '')
          chassis_artifact("#{hostname}_#{append}")
        end

        def disk_chassis_artifact(append = '')
          return host_artifact(append) unless knows_disk_chassis?
          host_artifact("#{disk_chassis}_#{append}")
        end

        def enclosure_artifact(append = '')
          return disk_chassis_artifact(append) unless knows_enclosure?
          disk_chassis_artifact("#{enclosure}_#{append}")
        end
      end
    end
  end
end
