require 'log4r'

module Cldtx
  module Logger
    LOG_FILE_LOC = File.join("/tmp", "cldtx_qa.log")
    def init_logger
      logger = Log4r::Logger.new(get_full_class_name)
      logger.level = Log4r.const_get(ENV["TEST_LEVEL"] || "DEBUG")
      pattern_formatter = Log4r::PatternFormatter.new(pattern: '[%l] %d :: [%h] %C :: %.10000m',
                                                      date_pattern: '%Y-%m-%d %H:%M:%S.%L')
      unless ENV['DISABLE_STDOUT_LOG']
        std_outputter = Log4r::Outputter.stdout
        std_outputter.formatter = pattern_formatter
        logger.outputters << std_outputter
      end
      file_outputter = Log4r::FileOutputter.new('syslog', filename: LOG_FILE_LOC )
      file_outputter.formatter = pattern_formatter
      logger.outputters << file_outputter
    end

    def logger
      init_logger unless Log4r::Logger[get_full_class_name]
      Log4r::Logger[get_full_class_name]
    end

    def get_full_class_name
      self.class == Class || self.class == Module ? self.name : self.class.name
    end
  end
end