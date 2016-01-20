module ReadyTalk
  class Account < ReadyTalkObject

    def self.get_option(option)
      response = request(:get, "/accounts/option/#{option}", :get_account_option)
      Util.new_helper_object(response, :option)
    end

    def self.list_international_numbers
      response = request(:get, '/accounts/internationalNumbers', :list_international_numbers)
      Util.new_list_object(response, :international_number)
    end

    def self.list_questions(opts = {})
      response = request(:get, '/registrations/pollQuestions', opts, :list_poll_questions)
      Util.new_list_object(response, :poll_question, :paging_criteria)
    end
  end
end
