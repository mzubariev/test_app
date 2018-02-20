def main(wd, test_data)
  home_page = TestApp::HomePage.new(wd)
  search_fr_page = home_page.search_for(test_data[:keyword])

  search_fr_page.parse_freelancers
  search_fr_page.verify_info_contains_keyword(test_data[:keyword])
  fr_profile_page = search_fr_page.navigate_to_fr_profile_page

  fr_profile_page.verify_freelancer_profile(search_fr_page.freelancers)
  fr_profile_page.verify_info_contains_keyword(test_data[:keyword])
end