module TestApp
  class SearchFreelancerPage < PageObject

    include Asserts::FreelancersAsserts
    attr_reader :freelancers

    SEARCH_RESULTS_SECTION = { id: 'oContractorResults'            }.freeze
    PAGINATION             = { css: '[data-qa="tile_description"]' }.freeze

    def initialize(wd)
      super
      @freelancers = []
    end

    def parse_freelancers
      wait_for { displayed?(PAGINATION) }
      @freelancers = Parser.new(find(SEARCH_RESULTS_SECTION)
                                    .attribute('innerHTML')).parse_freelancers_section
    end

    def navigate_to_fr_profile_page(freelancer_name = nil)
      fr_name = freelancer_name || random_freelancer_name
      logger.info("Navigate to freelancer '#{fr_name}' profile page...")
      click_on(link: fr_name)
      wait_for_page_to_load(FreelancerProfilePage.name)
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