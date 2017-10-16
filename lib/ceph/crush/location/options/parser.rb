require 'optparse'
module Ceph
  module Crush
    module Location
      # Holds options
      module Options
        def self.parse!
          Parser.parse!
        end

        # Parses it
        class Parser
          class << self
            def parse!
              ::Ceph::Crush::Location::Logger.send('parsing attributes')
              ::Ceph::Crush::Location.options = {}
              grab!
              validate!
              default_env
              env!
              ::Ceph::Crush::Location.options.freeze
            rescue OptionParser::MissingArgument => e
              report e
            end

            def default_env
              Ceph::Crush::Location::Logger.send('Options::Parser.default_env')
              ::Ceph::Crush::Location.options[:nodeinfo] =
                '/etc/nodeinfo/info.json'
            end

            def env!
              Ceph::Crush::Location::Logger.send('Options::Parser.env!')
              return unless ENV['NODE_INFO']
              ::Ceph::Crush::Location.options[:nodeinfo] = ENV['NODE_INFO']
            end

            def report(e)
              ::Ceph::Crush::Location::Logger.send(e, ::Logger::ERROR)
              STDERR.puts "#{$PROGRAM_NAME}: #{e}"
              exit(-1)
            end

            def usage(opts)
              Ceph::Crush::Location::Logger.send('Options::Parser.usage')
              opts.banner = "Usage: #{$PROGRAM_NAME} [options]"
              opts.separator ''
              opts.separator 'Specific options:'
            end

            def options(opts)
              Ceph::Crush::Location::Logger.send('Options::Parser.options')
              opts.on('-c', '--cluster CLUSTER', 'Specify Cluster Name') do |c|
                ::Ceph::Crush::Location.options[:cluster] = c
              end

              opts.on('-t', '--type TYPE', 'Specify Daemon Type') do |t|
                ::Ceph::Crush::Location.options[:type] = t
              end

              opts.on('-i', '--id ID', 'Specify Daemon ID') do |i|
                ::Ceph::Crush::Location.options[:id] = i
              end
            end

            def tail
              Ceph::Crush::Location::Logger.send('Options::Parser.tail')
              opts.on_tail('-h', '--help', 'Show this message') do
                puts opts
                exit
              end

              opts.on_tail('--version', 'Show version') do
                puts Ceph::Crush::Location::VERSION
                exit
              end
            end

            def grab!
              Ceph::Crush::Location::Logger.send('Options::Parser.grab!')
              OptionParser.new do |opts|
                usage(opts)

                options(opts)

                opts.separator ''
                opts.separator 'Common options:'
              end.parse!(ARGV)
            end

            def validate!
              Ceph::Crush::Location::Logger.send('Options::Parser.validate!')
              ::Ceph::Crush::Location.options.fetch(:cluster) do
                raise OptionParser::MissingArgument, 'no \'cluster\' provided'
              end
              ::Ceph::Crush::Location.options.fetch(:id) do
                raise OptionParser::MissingArgument, 'no \'id\' provided'
              end
              ::Ceph::Crush::Location.options.fetch(:type) do
                raise OptionParser::MissingArgument, 'no \'type\' provided'
              end
            end
          end
        end
      end
    end
  end
end
Ceph::Crush::Location::Options.parse!
