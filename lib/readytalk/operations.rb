module ReadyTalk
  module Operations

    def self.request(verb, path, params)
      opts = {
        method: verb,
        url: url(path),
        headers: {
          Authorization: authorization
        }
      }

      case verb
      when :post
        opts[:payload] = params
      else
        opts[:headers][:params] = params
      end

      RestClient::Request.execute(opts)
    end

    private
    def self.url(path)
      domain = ReadyTalk.config.test_mode ? 'apidev-cc.readytalk.com' : 'cc.readytalk.com'
      "https://#{domain}/api/1.3/svc/rs#{path}.json"
    end

    def self.authorization
      config = ReadyTalk.config
      credentials = "#{config.tollfree}:#{config.accesscode}:#{config.passcode}"
      encoded_credentials = Base64.strict_encode64(credentials)
      "Basic #{encoded_credentials}"
    end
  end
end
