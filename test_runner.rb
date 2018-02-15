$LOAD_PATH.concat(Dir.glob("#{ENV['GEM_HOME']}/gems/*/lib"))

require 'pry'
require 'optparse'
require 'selenium-webdriver'
require_relative 'framework/framework/logger/logger'
require_relative 'framework/framework/parser/parser'
require_relative 'framework/framework/helpers/data_comparator'
require_relative 'framework/framework/framework/selenium/base_page_object'

options = {}

OptionParser.new do |opts|
  opts.banner = %{ Usage: test_runner.rb [options]
    Example: ./test_runner.rb -f 1 -t 1 -d firefox_ruby }

  opts.on('-f f', 'Feature file number to run') do |f|
    options[:feature_file] = f
  end

  opts.on('-t t', 'Test case number to run') do |t|
    options[:test_case] = t
  end

  opts.on('-d d', 'Fixtures data file name') do |d|
    options[:data_file] = d
  end
end.parse!

test_case_file = Dir.glob("features/ff#{options[:feature_file]}_*/tc#{options[:test_case]}_*")[0]

if test_case_file.nil?
  raise 'The file with a test case has not found!'
else
  run(options[:data_file])
end