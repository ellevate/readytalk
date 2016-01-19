require 'rest-client'
require 'base64'
require 'readytalk/railtie'
require 'readytalk/api/operations'

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
      @@config ||= OpenStruct.new
      @@config
    end
  end
end
