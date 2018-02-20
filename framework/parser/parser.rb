module TestApp
  class Parser

    include Logger
    attr_reader :html_string

    def initialize(html_string)
      @html_string = html_string
    end

    def parse_freelancers_section
      logger.info('Parse found freelancers section...')
      freelancers = []
      freelancer_sections_arr = html_string.scan(/<article.*?>.+?<\/article>/m)
      freelancer_sections_arr.each do |freelancer_section|
        freelancers << {
          name: freelancer_section.match(/<a.*?data-qa=\"tile_name\".*?>(.*?)<\/a>/m)[1].strip,
          title: freelancer_section.match(/<h4.*?data-qa=\"tile_title\".*?>(.*?)<\/h4>/m)[1].strip,
          description: freelancer_section.match(/<p.*?data-qa=\"tile_description\".*?>(.*?)<\/p>/m)[1]
                         .gsub('...', '').strip
        }
      end
      freelancers
    end
  end
end