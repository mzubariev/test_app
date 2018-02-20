module TestApp
  class FreelancerProfilePage < PageObject

    include Asserts::FreelancersAsserts
    attr_reader :freelancer_profile

    FR_PROFILE_NAME =             { css: 'div.media-body h2>span>span' }.freeze
    FR_PROFILE_TITLE =            { class: 'fe-job-title'              }.freeze
    FR_PROFILE_DESCRIPTION =      { class: 'cfe-overview'              }.freeze
    COMPANY_PROFILE_NAME =        { css: 'div.media-body h2'           }.freeze
    COMPANY_PROFILE_TITLE =       { css: 'div.media-body h2'           }.freeze
    COMPANY_PROFILE_DESCRIPTION = { css: 'section>h2+div'              }.freeze

    def initialize(wd)
      super
      @freelancer_profile = freelancer_profile_fields_text
    end

    private

    def freelancer_profile_fields_text
      {
        name: displayed?(FR_PROFILE_NAME) ?
                  text_of(FR_PROFILE_NAME) : find(COMPANY_PROFILE_NAME).attribute('innerHTML'),
        title: displayed?(FR_PROFILE_TITLE) ?
                   text_of(FR_PROFILE_TITLE) : find(COMPANY_PROFILE_TITLE).attribute('innerHTML'),
        description: displayed?(FR_PROFILE_DESCRIPTION) ?
                         text_of(FR_PROFILE_DESCRIPTION) : find(COMPANY_PROFILE_DESCRIPTION).attribute('innerHTML')
      }
    end
  end
end