if defined?(Rails)
  require 'rails'
  module ReadyTalk
    class Railtie < Rails::Railtie
      config.readytalk = ActiveSupport::OrderedOptions.new
    end
  end
end
