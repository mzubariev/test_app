module TestApp
  module WebdriverUtils
    def navigate_to(url)
      driver.navigate.to(url)
    end
  end
end