module TestApp
  class Webdriver

    include Logger

    attr_reader :driver

    DEFAULT_BROWSER = :firefox
    BASE_URL = 'https://www.upwork.com/'

    def initialize(browser = nil)
      @driver = if browser.nil?
                  Selenium::WebDriver.for DEFAULT_BROWSER
                else
                  Selenium::WebDriver.for browser.to_sym
                end
      clear_cookie
      navigate_to(BASE_URL)
    end

    def navigate_to(url)
      @driver.navigate.to(url)
    end

    def clear_cookie
      @driver.manage.delete_all_cookies
    end

    def stop
      @driver.quit
    end
  end
end