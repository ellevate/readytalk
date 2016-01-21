# ReadyTalk
A Ruby wrapper for the ReadyTalk API. It provides a set of
classes that map to API endpoints and data structures.

## Installation
Include this line to your application's Gemfile:
```
gem 'readytalk'
```

And then execute:
```
$ bundle install
```

Or install it yourself as:
```
$ gem install readytalk
```

## Documentation
[ReadyTalk API Docs](https://cc.readytalk.com/api/1.3/rest)

## Configuration
If you are using Rails, the readytalk gem can be configured in an initializer or
environment file.

Configuration options can be passed as a block or set as a Hash.

```ruby
ReadyTalk.configure do |config|
  config.tollfree = 0000000000 # your toll free number
  config.accesscode = 1212121 # your access code
  config.passcode = 1234 # your passcode
  config.test_mode = true # if true, operate in sandbox mode: https://apidev-cc.readytalk.com
end
```
Outside the Rails environment configuration options can be set directly on the
`ReadyTalk` module.
```ruby
ReadyTalk.config.tollfree = 0000000000
ReadyTalk.config.accesscode = 1212121
ReadyTalk.config.passcode = 1234

```

## Usage
All ReadyTalk API endpoints have an equivalent method call. Consult API documentation
for list of required and optional input parameters.

* `ReadyTalk::Account`
  * `self.get_option(option_name)` - [Get Account Option](https://cc.readytalk.com/api/1.3/rest#AccountService-getAccountOption)
  * `self.list_international_numbers()` - [List International Numbers](https://cc.readytalk.com/api/1.3/rest#AccountService-listInternationalNumbers)
  * `self.list_questions(input_params)` - [List Poll Questions](https://cc.readytalk.com/api/1.3/rest#RegistrationService-listPollQuestions)

* `ReadyTalk::Meeting`
  * `self.create(input_params)` - [Create Meetings](https://cc.readytalk.com/api/1.3/rest#MeetingService-createMeeting)
  * `self.list(input_params)` - [List Meetings](https://cc.readytalk.com/api/1.3/rest#MeetingService-listMeetings)
  * `self.details(id)` - [Meeting Details](https://cc.readytalk.com/api/1.3/rest#MeetingService-meetingDetails)
  * `details()` - [Meeting Details](https://cc.readytalk.com/api/1.3/rest#MeetingService-meetingDetails)
  * `cancel(input_params)` - [Cancel Meeting](https://cc.readytalk.com/api/1.3/rest#MeetingService-cancelMeeting)
  * `update(input_params)` - [Update Meeting](https://cc.readytalk.com/api/1.3/rest#MeetingService-updateMeeting)
  * `create_registration(input_params)` - [Create Registration](https://cc.readytalk.com/api/1.3/rest#RegistrationService-createRegistration)
  * `create_invitations(input_params)` - [Create Invitations](https://cc.readytalk.com/api/1.3/rest#RegistrationService-createInvitations)
  * `list_registrations(input_params)` - [List Registrations](https://cc.readytalk.com/api/1.3/rest#RegistrationService-listRegistrations)
  * `list_surveys(input_params)` - [List Post Event Surveys](https://cc.readytalk.com/api/1.3/rest#RegistrationService-listPostEventSurveys)
  * `list_chats()` - [List Chats](https://cc.readytalk.com/api/1.3/rest#ChatService-listChats)

* `ReadyTalk::Recording`
  * `self.list(input_params)` - [List Recordings](https://cc.readytalk.com/api/1.3/rest#RecordingService-listRecordings)
  * `self.details(id, input_params)` - [Recording Details](https://cc.readytalk.com/api/1.3/rest#RecordingService-recordingDetails)
  * `details(input_params)` - [Recording Details](https://cc.readytalk.com/api/1.3/rest#RecordingService-recordingDetails)
  * `list_registrations(input_params)` - [List Recording Registrations](https://cc.readytalk.com/api/1.3/rest#RecordingRegistrationService-listRegistrations)

An example API call might resemble the following:
```ruby
  ReadyTalk::Meeting.create(
    title: 'Test Meeting',
    host_name: 'Stevie Tester',
    from_email: 'sevetester@example.com',
    start_date_iso8601: '2016-01-30T08:00:00-05:00',
    duration_in_seconds: '3600',
    time_zone: 'EST',
    registration: 'PRE_REG_AUTOMATIC_CONFIRMATION_NO_NOTIFICATION',
    type: 'WEB_AND_AUDIO',
    audio: {on_demand: 'DISPLAY_TOLLFREE_DISPLAY_TOLL'}
  )
```

The documented [API Data Types](https://cc.readytalk.com/api/1.3/rest#data-types)
have equivalent `ReadyTalk` namespaced classes. All attributes are accessible via
method calls.

```
  > meeting = ReadyTalk::Meeting.details(012345)
  => #<ReadyTalk::Meeting @data={"id"=>"012345"...}>
  > meeting.id
  => 012345
  > meeting.meeting_details
  => #<ReadyTalk::MeetingDetails @data={"meetingType"=>"WEB_AND_AUDIO"...}>
  > meeting.meeting_details.meeting_type
  => "WEB_AND_AUDIO"
```

API list endpoints return `ReadyTalk::ReadyTalkList` objects, which respond
to `[]`, `first`, `last`, `size`, `each`, and `empty?`.

Any additional attributes returned by a list endpoint, such as `paging_criteria`,
are also available via method calls on the list object.

## Handling Errors
Errors returned by the API are raised as `ReadyTalk::ReadyTalkError`. It is possible
for multiple errors to be returned for a given request. raw API errors are accessible
via the `errors` method on `ReadyTalk::ReadyTalkError`.

Additionally, the `full_messages` method will return an Array containing the messages
for each error.

## TODO/Coming Soon
Tests will be coming very shortly. I also plan on developing a mock webhook for
use in external projects.
