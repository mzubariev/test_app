$LOAD_PATH.concat(Dir.glob("#{ENV['GEM_HOME']}/gems/*/lib"), [])

require 'pry'
require 'optparse'
require 'selenium-webdriver'
require 'json'
require_relative 'framework/logger/logger'
require_relative 'framework/parser/parser'
require_relative 'framework/selenium/webdriver'
require_relative 'framework/selenium/page_object'
require_relative 'framework/selenium/webdriver_utils'
require_relative 'framework/asserts/freelancers_asserts'
require_relative 'framework/selenium/pages/home_page'
require_relative 'framework/selenium/pages/search_freelancer_page'
require_relative 'framework/selenium/pages/freelancer_profile_page'

module TestApp
  class TestRunner

    include Logger

    def run
      logger.info('Start test_runner main script.')

      options = {}

      OptionParser.new do |opts|
        opts.banner = %{ Usage: test_runner.rb [options]
          Example: ./test_runner.rb -f 1 -t 1 -b chrome -d search_freelancer_keyword
          -f: feature file (mandatory)
          -t: test case (mandatory)
          -b: browser (optional. Default: firefox)
          -d: data file (different setup data that is not/needed for definite test)
        }

        opts.on('-f f', 'Feature file number to run') do |f|
          options[:feature_file] = f
        end

        opts.on('-t t', 'Test case number to run') do |t|
          options[:test_case] = t
        end

        opts.on('-b b', 'Browser') do |b|
          options[:browser] = b
        end

        opts.on('-d d', 'Fixtures data file name') do |d|
          options[:data_file] = d
        end
      end.parse!

      test_case_file = Dir.glob("features/ff#{options[:feature_file]}_*/tc#{options[:test_case]}_*")[0]

      if test_case_file.nil?
        raise 'The file with a test case has not found!'
      else
        require_relative test_case_file
        test_data = options[:data_file] ? JSON.parse(File.read("fixtures/#{options[:data_file]}.json")) : nil
        webdriver = Webdriver.new(options[:browser])
        logger.info('Run test file.')
        main(webdriver.driver, test_data)
        logger.info('Test finished.')
        webdriver.stop
      end
    end
  end
end

TestApp::TestRunner.new.run