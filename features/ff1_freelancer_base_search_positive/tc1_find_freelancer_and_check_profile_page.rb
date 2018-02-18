def main(webdriver, test_data)
  home_page = TestApp::HomePage.new(webdriver)
  search_freelancer_page = home_page.search_for(test_data['keyword'])

  search_freelancer_page.parse_freelancers
  search_freelancer_page.check_freelancers_info_contains_keyword(test_data['keyword'])
  freelancer_profile_page = search_freelancer_page.navigate_to_freelancer_profile_page

  freelancer_profile_page.check_freelancer_profile(search_freelancer_page.freelancers)
  freelancer_profile_page.check_freelancer_info_contains_keyword(test_data['keyword'])
end