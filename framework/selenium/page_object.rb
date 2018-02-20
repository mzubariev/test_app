module TestApp
  class PageObject

    attr_reader :wd

    DEFAULT_WAITING_TIMEOUT = 10

    def initialize(wd)
      @wd = wd
    end

    def navigate_to(url)
      wd.navigate.to(Webdriver::BASE_URL + url)
    end

    def find(locator)
      wd.find_element(locator)
    end

    def type(locator, text)
      find(locator).send_keys([:control, 'a'], :backspace, text)
    end

    def click_on(locator)
      find(locator).click
    end

    def displayed?(locator)
      begin
        wd.find_element(locator).displayed?
      rescue Selenium::WebDriver::Error::NoSuchElementError
        false
      end
    end

    def text_of(locator)
      find(locator).text
    end

    def wait_for(seconds = DEFAULT_WAITING_TIMEOUT)
      Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
    end

    def wait_for_page_to_load
      wait_for do
        wd.execute_script("return document.querySelector('link[rel=\"icon\"]') !== null")
      end
    end
  end
end