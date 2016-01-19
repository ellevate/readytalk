module ReadyTalk
  module API
    module Operations
      def post(path, params = {})
        request(:post, path, params)
      end

      def get(path, params = {})
        request(:get, path, params)
      end

      def put(path, params = {})
        request(:put, path, params)
      end

      def delete(path, params = {})
        request(:delete, path, params)
      end

      private
      def request(verb, path, params)
        opts = {
          method: verb,
          url: url(path),
          headers: {
            Authorization: authorization
          }
        }
        if verb == :post
          opts[:payload] = params
        else
          opts[:headers][:params] = params
        end

        RestClient::Request.execute(opts)
      end

      def url(path)
        domain = ReadyTalk.config.test_mode ? "apidev-cc.readytalk.com" : "cc.readytalk.com"
        "https://#{domain}/api/1.3/svc/rs#{path}.json"
      end

      def authorization
        config = ReadyTalk.config
        credentials = "#{config.tollfree}:#{config.accesscode}:#{config.passcode}"
        encoded_credentials = Base64.strict_encode64(credentials)
        "Basic #{encoded_credentials}"
      end
    end
  end
end
