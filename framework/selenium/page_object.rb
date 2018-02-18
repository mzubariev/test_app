module TestApp
  module PageObject
    def page_element(method_name, selector, value)
      define_method(method_name) do
        begin
          Timeout.timeout(20) do
            driver.find_element(selector, value)
          end
        rescue Selenium::WebDriver::Error::NoSuchElementError
          false
        end
      end
    end
  end
end