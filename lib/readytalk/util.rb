module ReadyTalk
  module Util
    def process_opts(opts)
      return {} if opts.nil?

      Hash[opts.map { |k, v| [to_camel(k), v] }]
    end

    def to_param(key)
      str = key.to_s
      return str if str.include?('_')

      str.gsub(/([A-Z])/) { "_#{$1.downcase}" }
    end

    def to_camel(key)
      str = key.to_s
      return str unless str.include?('_')

      str.downcase.gsub!(/(?:_|(\/))([a-z\d]*)/) { $2.capitalize }
    end
  end
end
