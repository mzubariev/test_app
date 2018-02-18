module TestApp
  class SearchFreelancerPage

    extend PageObject
    include WebdriverUtils
    include Logger
    include Asserts::FreelancersAsserts
    attr_reader :driver, :freelancers

    page_element(:search_resulsts_section, :id, 'oContractorResults')

    def initialize(driver)
      @driver = driver
      @freelancers = []
    end

    def check_freelancers_info_contains_keyword(keyword)
      freelancers.each do |freelancer|
        logger_string = "\nFreelancer #{freelancer[:name]}:"
        freelancer.each do |key, value|
          next if key == :name
          logger_string << if value.downcase.include?(keyword.downcase)
                             "\n+ field '#{key}' contains keyword '#{keyword}'"
                           else
                             "\n- field '#{key}' does not contain keyword '#{keyword}'"
                           end
        end
        logger.info(logger_string + "\n")
      end
    end

    def navigate_to_freelancer_profile_page(freelancer_name = nil)
      driver.find_element(:link, freelancer_name || random_freelancer_name).click
      FreelancerProfilePage.new(driver)
    end

    def parse_freelancers
      @freelancers = Parser.new(search_resulsts_section.attribute('innerHTML'))
                         .parse_freelancers_section
    end

    private

    def freelancers_count
      freelancers.count
    end

    def random_freelancer_name
      freelancers[rand(0...freelancers_count)][:name]
    end
  end
end