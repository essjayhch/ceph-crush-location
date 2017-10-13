require 'optparse'
require 'ostruct'
module Ceph
  module Crush
    module Location
      mattr_accessor :options
      module Options
        class Parser
          class << self
            def parse
              options = OpenStruct.new
              ::Ceph::Crush::Location.options = OptionParser.new do |opts|
                opts.banner = "Usage $0 [options]"
                opts.separator ''
                opts.separator 'Specific options:r'
                opts.on('-c', '--cluster CLUSTER', 'Specify Cluster Name') do |c|
                  options.cluster = c
                end

                opts.on('-t', '--type TYPE', 'Specify Daemon Type') do |t|
                  options.type = t
                end

                opts.on('-i', '--id ID', 'Specify Daemon ID') do |i|
                  options.id = i
                end

                opts.on_tail('-h', '--help', 'Show this message') do
                  puts opts
                  exit
                end

                opts.on_tail('--version', 'Show version') do
                  puts Ceph::Crush::Location::VERSION.join('.')
                  exit
                end
              end.parse!(ARGV)
            end
          end
        end
      end
    end
  end
end
