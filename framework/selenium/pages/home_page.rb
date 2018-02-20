module TestApp
  class HomePage < PageObject

    SEARCH_INPUT =          { id: 'q'                          }.freeze
    SEARCH_BUTTON =         { class: 'air-icon-search'         }.freeze
    FIND_FREELANCERS_LINK = { partial_link_text: 'Freelancers' }.freeze

    def initialize(wd)
      super
    end

    def search_for(search_text)
      click_on(SEARCH_BUTTON)
      click_on(FIND_FREELANCERS_LINK)
      type(SEARCH_INPUT, search_text)
      find(SEARCH_INPUT).send_keys(:enter)
      wait_for_page_to_load
      SearchFreelancerPage.new(wd)
    end
  end
end