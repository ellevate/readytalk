module ReadyTalk
  module API
    class Object
      extend Operations
      extend ReadyTalk::Util

      def initialize(json_data, keys = nil)
        @attrs = case json_data
        when String
          JSON.parse(json_data)
        when Hash, Array
          json_data
        else
          raise ArgumentError.new
        end

        unless keys.nil?
          keys.each do |key|
            @attrs = @attrs[key] || @attrs
          end
        end

        @attrs.each do |key, value|
          _key = self.class.to_param(key)
          self.class.send(:define_method, "#{_key}") { @attrs[key] }
        end
      end

    end
  end
end
