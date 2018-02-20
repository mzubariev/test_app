module TestApp
  class SearchFreelancerPage < PageObject

    include Logger
    include Asserts::FreelancersAsserts
    attr_reader :freelancers

    SEARCH_RESULTS_SECTION = { id: 'oContractorResults' }.freeze

    def initialize(wd)
      super
      @freelancers = []
    end

    def parse_freelancers
      @freelancers = Parser.new(find(SEARCH_RESULTS_SECTION)
                                    .attribute('innerHTML')).parse_freelancers_section
    end

    def navigate_to_fr_profile_page(freelancer_name = nil)
      click_on(link: freelancer_name || random_freelancer_name)
      wait_for_page_to_load
      FreelancerProfilePage.new(wd)
    end

    private

    def freelancers_count
      @freelancers.count
    end

    def random_freelancer_name
      @freelancers[rand(0...freelancers_count)][:name]
    end
  end
end