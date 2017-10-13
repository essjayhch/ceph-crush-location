module Ceph
  module Crush
    module Location
      # Logs things
      module Logger
        mattr_accessor :loggers

        def self.add_logger_instance(logger)
          loggers << logger
        end

        def self.send(message, level = ::Logger::INFO)
          return unless loggers
          loggers.each do |l|
            send_log_message(message, l, level)
          end
        end

        def self.send_log_message(message, logger, level = ::Logger::INFO)
          return logger.info(message) if level == ::Logger::INFO
          return logger.error(message) if level == ::Logger::ERR
          return logger.warn(message) if level == ::Logger::WARN
          logger.debug(message)
        end
      end
    end
  end
end
