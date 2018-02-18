module TestApp
  class HomePage

    extend PageObject
    include WebdriverUtils
    attr_reader :driver

    page_element(:search_input, :id, 'q')
    page_element(:search_button, :class, 'air-icon-search')
    page_element(:find_freelancers_link, :partial_link_text, 'Freelancers')

    def initialize(driver)
      @driver = driver
    end

    def search_for(search_text)
      search_button.click
      find_freelancers_link.click
      search_input.send_keys([:control, 'a'], :space, search_text, :enter)
      SearchFreelancerPage.new(driver)
    end
  end
end