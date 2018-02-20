$LOAD_PATH.concat(Dir.glob("#{ENV['GEM_HOME']}/gems/*/lib"), [])

require 'pry'

require 'selenium-webdriver'
require_relative 'framework/logger/logger'
require_relative 'framework/parser/parser'
require_relative 'framework/selenium/webdriver'
require_relative 'framework/selenium/page_object'
require_relative 'framework/asserts/freelancers_asserts'
require_relative 'framework/selenium/pages/home_page'
require_relative 'framework/selenium/pages/search_freelancer_page'
require_relative 'framework/selenium/pages/freelancer_profile_page'

module TestApp
  class TestRunner

    include Logger
    attr_reader :ff, :tc

    def initialize(ff, tc)
      @ff = ff
      @tc = tc
    end

    def run
      logger.info('Start test_runner main script.')

      test_case_file = Dir.glob("features/ff#{ff}_*/tc#{tc}_*")[0]

      if test_case_file.nil?
        raise 'The file with a test case has not found!'
      else
        test_data = {}
        fixture_file_path = "fixtures/#{ff}.#{tc}.txt"
        if File.file?(fixture_file_path)
          File.readlines(fixture_file_path).each do |line|
            key, value = line.strip.split(' = ')
            test_data[key.to_sym] = value
          end
        end
        wd = Webdriver.new(test_data[:browser])
        execute_test_file(test_case_file, wd.driver, test_data)
        wd.stop
      end
    end

    private

    def execute_test_file(test_case_file, wd, test_data = {})
      require_relative test_case_file
      logger.info('Run test file.')
      main(wd, test_data)
      logger.info('Test finished.')
    end
  end
end

TestApp::TestRunner.new(*ARGV[0].split('.')).run