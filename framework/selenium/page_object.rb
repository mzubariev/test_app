module TestApp
  class PageObject

    include Logger
    attr_reader :wd

    DEFAULT_WAITING_TIMEOUT = 10

    def initialize(wd)
      @wd = wd
    end

    def navigate_to(url)
      logger.info("Navigating to address: #{url}")
      wd.navigate.to(Webdriver::BASE_URL + url)
    end

    def find(locator)
      wd.find_element(locator)
    end

    def type(locator, text)
      logger.info("Type text '#{text}' to the input with locator #{locator}")
      find(locator).send_keys([:control, 'a'], :backspace, text)
    end

    def click_on(locator)
      logger.info("Click on the element with locator #{locator}")
      find(locator).click
    end

    def displayed?(locator)
      logger.info("Check is element with locator #{locator} displayed?")
      begin
        wd.find_element(locator).displayed?
      rescue Selenium::WebDriver::Error::NoSuchElementError
        false
      end
    end

    def text_of(locator)
      logger.info("Get text of element with locator #{locator}")
      find(locator).text
    end

    def wait_for(seconds = DEFAULT_WAITING_TIMEOUT)
      Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
    end

    def wait_for_page_to_load(page)
      logger.info("Waiting for page #{page} to load...")
      wait_for do
        wd.execute_script("return document.querySelector('link[rel=\"icon\"]') !== null")
      end
    end
  end
end