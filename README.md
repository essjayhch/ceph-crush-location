# Ceph::Crush::Location

This module is designed as an assistent to the [Ceph OSD](https://ceph.com) daemon.
On starting a Ceph OSD, the daemon will invoke an executable as detailed in the config.

```ini
[osd]
osd_crush_location_hook = /path/to/crush/location/bin
```

Ceph invokes this executable with the following options:
    --cluster CLUSTER
    --id ID
    --type DAEMON_TYPE

## Installation

Install it yourself as:

    $ gem install ceph-crush-location

## Usage

This file takes information about the node from a file called `/etc/nodeinfo/info.json`. This can contain information about what datacenter, row, rack and chassis a host is in.
This is useful for maintaining redundancy of data.

the json file can take the following format
```json
{
  "datacenter": "dc",
  "row": "1",
  "rack": "rackname",
  "chassis": "chassis-name"
}
```

Should this file not be available from this location, you can specify the location using `ENV['NODE_INFO']`

Should this file be missing, or if it is corrupted, it will behave as if it was not there and behave as with the defaults

Beyond that there are three lower types provided which are derived as follows:
    root # Crush root, either default, or read from /path/to/osd/crush_root
    disk_chassis # JBOD level of redundancy read from /path/to/osd/disk_chassis
    enclosure # Enclosure/backplane read from /path/to/osd/enclosure

If any of the crush bucket information items are not retrievable (or not provided), they will be ommitted.

Each bucket is maintained as unique by concatenating all higher level bucket names to the lower one, thus if you ignore a bucket layer in the middle, the disk will fall potentially into a different bucket from what you are expecting.

Your crush ruleset will require the following types to use this gem:
    type 0 osd
    type 1 enclosure
    type 2 disk_chassis
    type 3 host
    type 4 chassis
    type 5 rack
    type 6 row
    type 7 datacenter
    type 8 root

### Config crush_location

For any daemon, ceph optionally provides a `crush_location` option that can be set in the cluster configuration file on the host this script is invoked. Providing this for will override the operation of this script and return that value instead.
ie setting it for [osd] will override all OSDSs on this host, setting it for [osd.N] will override for that osd only.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/essjayhch/ceph-crush-location.

