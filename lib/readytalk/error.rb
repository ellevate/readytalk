module ReadyTalk
  class ReadyTalkError < StandardError
    attr_reader :errors

    def initialize(errors_data = {})
      @errors = errors_data['error'] || []
    end

    def full_messages
      @errors.map { |e| e['message'] }
    end

    def to_s
      "#{@errors.size} error(s): #{@errors.map { |e| "#{e['code']}: #{e['message']}" }}"
    end

  end
end
