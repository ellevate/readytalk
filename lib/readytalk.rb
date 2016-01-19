module ReadyTalk
  if defined?(Rails)
    def self.configure(&block)
      if block_given?
        block.call(ReadyTalk::Railtie.config.readytalk)
      else
        ReadyTalk::Railtie.config.readytalk
      end
    end

    def self.config
      ReadyTalk::Railtie.config.readytalk
    end
  else
    def self.config
      @@config ||= OpenStruct.new(api_key: nil)
      @@config
    end
  end
end
