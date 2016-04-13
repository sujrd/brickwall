module Brickwall
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end

  class Configuration
    attr_accessor :brick_public_key, :brick_private_key,
                  :widget_project_key, :widget_secret_key

    def configured?
      present?(brick_public_key) &&
        present?(brick_private_key) &&
        present?(widget_project_key) &&
        present?(widget_secret_key)
    end

    private

    def present?(str)
      str != nil && str.match(/\A\s*\z/) == nil
    end
  end
end

require 'brickwall/version'
