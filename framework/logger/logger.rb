require 'logger'

module TestApp
  module Logger

    def logger
      @logger ||= TestApp::Logger.logger_for(full_class_name)
    end

    @loggers = {}

    class << self
      def logger_for(full_class_name)
        @loggers[full_class_name] ||= configure_logger_for(full_class_name)
      end

      def configure_logger_for(full_class_name)
        logger = ::Logger.new(STDOUT)
        logger.progname = full_class_name
        logger.level = ::Logger::INFO
        logger.datetime_format = '%Y-%m-%d %H:%M:%S'
        logger
      end
    end

    def full_class_name
      self.class == Class || self.class == Module ? self.name : self.class.name
    end
  end
end
