module Ceph
  module Crush
    module Location
      # Derives a Bucket line for Crush
      class Bucket
        def initialize
          Ceph::Crush::Location::Logger.send('Bucket.initialize')
          @osd = OSD.new
        end

        def to_s
          Ceph::Crush::Location::Logger.send('Bucket.to_s')
          [root_bucket, datacenter_bucket,
           row_bucket, rack_bucket, chassis_bucket,
           host_bucket, disk_chassis_bucket, enclosure_bucket].join('')
        end

        private

        def root_bucket
          Ceph::Crush::Location::Logger.send('Bucket.root_bucket')
          "root=#{@osd.root}"
        end

        def datacenter_bucket
          Ceph::Crush::Location::Logger.send('Bucket.datacenter_bucket')
          " datacenter=#{datacenter}" if @osd.knows_datacenter?
        end

        def datacenter
          Ceph::Crush::Location::Logger.send('Bucket.datacenter')
          @osd.root_artifact(@osd.datacenter)
        end

        def row_bucket
          Ceph::Crush::Location::Logger.send('Bucket.row_bucket')
          " row=#{row}" if @osd.knows_row?
        end

        def row
          Ceph::Crush::Location::Logger.send('Bucket.row')
          @osd.datacenter_artifact(@osd.row)
        end

        def rack_bucket
          Ceph::Crush::Location::Logger.send('Bucket.rack_bucket')
          " rack=#{rack}" if @osd.knows_rack?
        end

        def rack
          Ceph::Crush::Location::Logger.send('Bucket.rack')
          @osd.row_artifact(@osd.rack)
        end

        def chassis_bucket
          Ceph::Crush::Location::Logger.send('Bucket.chassis_bucket')
          " chassis=#{chassis}" if @osd.knows_chassis?
        end

        def chassis
          Ceph::Crush::Location::Logger.send('Bucket.chassis')
          @osd.rack_artifact(@osd.chassis)
        end

        def host_bucket
          Ceph::Crush::Location::Logger.send('Bucket.host_bucket')
          " host=#{host}"
        end

        def host
          Ceph::Crush::Location::Logger.send('Bucket.host')
          @osd.chassis_artifact(@osd.hostname)
        end

        def disk_chassis_bucket
          Ceph::Crush::Location::Logger.send('Bucket.disk_chassis_bucket')
          " disk_chassis=#{disk_chassis}" if @osd.knows_disk_chassis?
        end

        def disk_chassis
          Ceph::Crush::Location::Logger.send('Bucket.disk_chassis')
          @osd.host_artifact(@osd.disk_chassis)
        end

        def enclosure_bucket
          Ceph::Crush::Location::Logger.send('Bucket.enclosure_bucket')
          " enclosure=#{enclosure}" if @osd.knows_enclosure?
        end

        def enclosure
          Ceph::Crush::Location::Logger.send('Bucket.enclosure')
          @osd.disk_chassis_artifact(@osd.enclosure)
        end
      end
    end
  end
end
