module ReadyTalk
  class Meeting < ReadyTalk::API::Object

    def self.create(opts = {})
      self.new(post('/meetings', process_opts(opts)), ['createMeetingsResult', 'meeting'])
    end

    def self.list(opts = {})
      response = get('/meetings', process_opts(opts))
      ReadyTalk::API::List.new(response, Meeting, ['listMeetingsResult', 'meeting'])
    end

    def self.details(id)
      new(get("/meetings/#{id}"), ['meetingDetailsResult', 'meeting'])
    end

    def cancel(opts = {})
      Raise 'Method not yet implemented'
      # self.class.delete("/meetings/#{id}", self.class.process_opts(opts))
    end

    def update(opts = {})
      Raise 'Method not yet implemented'
      # self.class.put("/meetings/#{id}", self.class.process_opts(opts))
    end

    def details
      response = self.class.get("/meetings/#{self.id}")
      Registration.new(response, ['meetingDetailsResult', 'meeting'])
    end

    def create_registration(opts = {})
      opts = opts.merge(meeting_id: self.id)
      response = self.class.post('/registrations', self.class.process_opts(opts))
      Registration.new(response, ['createRegistrationResult', 'meeting'])
    end

    def list_registrations(opts = {})
      opts = opts.merge(meeting_id: self.id)
      response = self.class.get('/registrations', self.class.process_opts(opts))
      ReadyTalk::API::List.new(response, Registration, ['listRegistrationsResult', 'registration'])
    end

    def list_questions(opts = {})
      opts = opts.merge(meeting_id: self.id)
      self.class.get('/registrations/pollQuestions', self.class.process_opts(opts))
    end

    def list_surveys(opts = {})
      opts = opts.merge(meeting_id: self.id)
      self.class.get('/registrations/surveys', self.class.process_opts(opts))
    end

  end
end
