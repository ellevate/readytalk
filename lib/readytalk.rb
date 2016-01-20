require 'base64'
require 'json'
require 'rest-client'

require 'readytalk/railtie'
require 'readytalk/operations'
require 'readytalk/util'
require 'readytalk/object'
require 'readytalk/list'

require 'readytalk/account'
require 'readytalk/error'
require 'readytalk/meeting'
require 'readytalk/recording'


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
