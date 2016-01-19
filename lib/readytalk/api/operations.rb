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

      private
      def request(verb, path, params)
        opts = {
          method: verb,
          url: url(path),
          headers: {
            params: params,
            Authorization: authorization
          }
        }
        RestClient::Request.execute(opts)
      end

      def url(path)
        "https://cc.readytalk.com#{path}.json"
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
