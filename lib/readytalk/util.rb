module ReadyTalk
  module Util

    def self.format_hash(hash)
      return {} if hash.nil?
      rv = {}
      hash.each do |k, v|
        if v.is_a?(Hash)
          nested = format_hash(v)
          nested.each { |kn, vn| rv["#{camelize(k)}.#{kn}"] = vn }
        else
          rv[camelize(k)] = v
        end
      end

      return rv
    end

    def self.camelize_hash(hash)
      return {} if hash.nil?

      Hash[hash.map { |k, v| [camelize(k), v] }]
    end

    def self.parameterize_hash(hash)
      return {} if hash.nil?

      Hash[hash.map { |k, v| [parameterize(k), v] }]
    end

    def self.parameterize(key)
      str = key.to_s
      return str if str.include?('_')

      str.gsub(/([A-Z])/) { "_#{$1.downcase}" }
    end

    def self.camelize(key)
      str = key.to_s
      return str unless str.include?('_')

      str.downcase.gsub!(/(?:_|(\/))([a-z\d]*)/) { $2.capitalize }
    end

    def self.create_helper_object(name, *args)
      klass = Class.new(ReadyTalkObject)
      Object.const_set(name, klass)
      klass.send(:new, *args)
    end

    def self.new_helper_object(data, object_key)
      klass = get_object_class(object_key)
      klass.send(:new, data, object_key)
    end

    def self.new_list_object(data, list_key, *data_keys)
      klass = get_object_class(list_key)
      ReadyTalkList.new(data, list_key, klass, data_keys)
    end

    private
    def self.get_object_class(key)
      @@object_classes ||= {
        recording: Recording,
        meeting: Meeting
      }
      klass = @@object_classes[key]
      if klass.nil?
        klass = create_object_class(key)
        @@object_classes[key] = klass
      end

      return klass
    end

    def self.create_object_class(key)
      name = camelize(key)
      name = "#{name[0].upcase}#{name[1..-1]}"
      klass = Class.new(ReadyTalkObject)

      ReadyTalk.const_set(name, klass)
      return klass
    end

  end
end
