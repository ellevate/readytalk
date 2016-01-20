module ReadyTalk
  class ReadyTalkList
    def initialize(data, list_key, klass, data_keys = nil)
      @klass = klass
      @list_data = data[ReadyTalk::Util.camelize(list_key)] || []
      @list_data = @list_data.map { |d| klass.new(d) }

      unless data_keys.nil?
        data_keys.each do |key|
          key_data = data[ReadyTalk::Util.camelize(key)]
          if key_data.is_a?(Hash)
            key_data = ReadyTalk::Util.new_helper_object(data, key)
          end

          self.class.send(:attr_reader, key)
          self.instance_variable_set("@#{key.to_s}", key_data)
        end
      end
    end

    def [](value)
      @list_data[value]
    end

    def first(*args)
      @list_data.send(:first, *args)
    end

    def last(*args)
      @list_data.send(:last, *args)
    end

    def size
      @list_data.size
    end

    def each(&block)
      @list_data.each(&block)
    end

    def empty?
      @list_data.empty?
    end

    alias_method :count, :size

  end
end
