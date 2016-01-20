module ReadyTalk
  class Recording < ReadyTalkObject

    def self.list(opts = {})
      response = request(:get, '/recordings', opts, :list_recordings)
      ReadyTalk::Util.new_list_object(response, :recording, :paging_criteria)
    end

    def self.details(id, opts = {})
      response = request(:get, "/recordings/#{id}", opts, :recording_details)
      self.new(response, :recording)
    end

    def details(opts = {})
      self.class.details(self.id, opts)
    end

    def list_registrations(opts = {})
      opts = opts.merge(recording_id: self.id)
      response = request(:get, '/recording/registrations', opts, :list_registrations)
      ReadyTalk::Util.new_list_object(response, :registration, :paging_criteria)
    end

  end
end
