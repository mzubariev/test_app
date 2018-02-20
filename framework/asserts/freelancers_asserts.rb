module TestApp
  module Asserts
    module FreelancersAsserts

      extend Logger

      def verify_info_contains_keyword(keyword)
        freelancers_arr = !@freelancer_profile.nil? ? [@freelancer_profile] : @freelancers
        logger.info("*********Search for keyword in reelancers info************\n")
        freelancers_arr.each do |freelancer|
          logger_arr = ["Freelancer #{freelancer[:name]}:"]
          logger_arr.append(search_fileds_for_keyword_log(freelancer, keyword)).flatten
          logger.info(logger_arr.join("\n") + "\n")
        end
      end

      def verify_freelancer_profile(freelancers)
        freelancer = freelancers.find { |freelancer| freelancer[:name] == @freelancer_profile[:name] }
        logger.info("*****Profile page of #{freelancer[:name]}*****")
        @freelancer_profile.each do |key, value|
          if value.include?(freelancer[key.to_sym])
            logger.info("+ Profile field #{key} matches with the same field from preview.")
          else
            logger.error("- Profile field #{key} does not match with the same field from preview.")
          end
        end
      end

      private

      def search_fileds_for_keyword_log(freelancer, keyword)
        result_arr = []
        freelancer.each do |key, value|
          next if key == :name
          result_arr << if value.downcase.include?(keyword.downcase)
                          "+ field '#{key}' contains keyword '#{keyword}'"
                        else
                          "- field '#{key}' does not contain keyword '#{keyword}'"
                        end
        end
        result_arr
      end
    end
  end
end