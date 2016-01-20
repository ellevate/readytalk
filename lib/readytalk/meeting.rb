module ReadyTalk
  class Meeting < ReadyTalkObject

    def self.create(opts = {})
      response = request(:post, '/meetings', opts, :create_meeting)
      self.new(response, :meeting)
    end

    def self.list(opts = {})
      response = request(:get, '/meetings', opts, :list_meetings)
      Util.new_list_object(response, :meeting, :paging_criteria)
    end

    def self.details(id)
      response = request(:get, "/meetings/#{id}", :meeting_details)
      self.new(response, :meeting)
    end

    def details
      self.class.details(self.id)
    end

    def cancel(opts = {})
      response = request(:delete, "/meetings/#{id}", opts, :cancel_meeting)
      Util.parameterize_hash(response)
    end

    def update(opts = {})
      response = request(:put, "/meetings/#{id}", opts, :update_meeting)
      update_data(response, :meeting)
    end

    def create_registration(opts = {})
      opts = opts.merge(meeting_id: self.id)
      response = request(:post, '/registrations', opts, :create_registration)
      Util.new_helper_object(response, :registration)
    end

    def create_invitations(opts = {})
      opts = opts.merge(meeting_id: self.id)
      opts[:email] = opts.fetch(:email, []).join(',')
      response = request(:post, '/invites', opts, :create_invitations)
      Util.new_list_object(response, :invite, :opt_out_email)
    end

    def list_registrations(opts = {})
      opts = opts.merge(meeting_id: self.id)
      response = request(:get, '/registrations', opts, :list_registrations)
      Util.new_list_object(response, :registration, :paging_criteria)
    end

    def list_surveys(opts = {})
      opts = opts.merge(meeting_id: self.id)
      response = request(:get, '/registrations/surveys', opts, :list_post_event_surveys)
      Util.new_list_object(response, :survey, :paging_criteria, :custom_link)
    end

    def list_chats
      response = request(:get, '/chats', {id: self.id}, :list_chats)
      Util.new_list_object(response, :chat)
    end

  end
end
