module ReadyTalk
  class ReadyTalkObject

    def initialize(data, object_key = nil)
      if object_key.nil?
        @data = data
      else
        @data = data[Util.camelize(object_key)]
      end

      unless @data.nil?
        @data.each do |key, _value|
          name = Util.parameterize(key)
          self.class.send(:define_method, "#{name}") do
             value = @data[key]
             case value
             when Array
               value = Util.new_list_object({key => value}, key)
               @data[key] = value
             when Hash
               value = Util.new_helper_object({key => value}, key)
               @data[key] = value
             end

             value
          end
        end
      end
    end

    protected
    def update_data(data, object_key = nil)
      if object_key.nil?
        @data = data
      else
        @data = data[Util.camelize(object_key)]
      end
    end

    def request(*args)
      self.class.request(*args)
    end

    def self.request(*args)
      verb = args.first
      path = args[1]
      end_point = args.last
      opts = args.size == 4 ? args[2] : {}

      opts = Util.format_hash(opts)
      end_point = Util.camelize(end_point)

      begin
        response = Operations.request(verb, path, opts)
        JSON.parse(response)["#{end_point}Result"]
      rescue => e
        response = e.response
        error_data = JSON.parse(response)['errorsResult']
        raise ReadyTalkError.new(error_data)
      end
    end

  end
end
