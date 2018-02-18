module TestApp
  class FreelancerProfilePage

    extend PageObject
    include WebdriverUtils
    include Logger
    include Asserts::FreelancersAsserts
    attr_reader :driver, :freelancer_profile

    page_element(:profile_name, :css, 'div.media-body h2>span>span')
    page_element(:profile_title, :class, 'fe-job-title')
    page_element(:profile_description, :class, 'cfe-overview')
    page_element(:company_profile_name, :css, 'div.media-body h2')
    page_element(:company_profile_title, :css, 'div.media-body h2')
    page_element(:company_profile_description, :css, 'section>h2+div')

    def initialize(driver)
      @driver = driver
      @freelancer_profile = freelancer_profile_fields_text
    end

    def check_freelancer_info_contains_keyword(keyword)
      logger_string = "\nFreelancer #{freelancer_profile[:name]}:"
      freelancer_profile.each do |key, value|
        next if key == :name
        logger_string << if value.downcase.include?(keyword.downcase)
                           "\n+ field '#{key}' contains keyword '#{keyword}'"
                         else
                           "\n- field '#{key}' does not contain keyword '#{keyword}'"
                         end
      end
      logger.info(logger_string + "\n")
    end

    def check_freelancer_profile(freelancers)
      freelancer = freelancers.find { |freelancer| freelancer[:name] == freelancer_profile[:name] }
      freelancer_profile.each do |key, value|
        if value.include?(freelancer[key.to_sym])
          logger.info("+ Profile field #{key} matches with the same field from preview.")
        else
          logger.error("- Profile field #{key} does not match with the same field from preview.")
        end
      end
    end

    private

    def freelancer_profile_fields_text
      {
        name: profile_name ? profile_name.text : company_profile_name.attribute('innerHTML'),
        title: profile_title ? profile_title.text : company_profile_title.attribute('innerHTML'),
        description: profile_description ? profile_description.text : company_profile_description.attribute('innerHTML')
      }
    end
  end
end