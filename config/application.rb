require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cerebrosus
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # SSL/ HTTPS
    # Changes to be done in puma.rb for rail environment.
    config.force_ssl = false  
    if config.force_ssl
      middleware.use ::ActionDispatch::SSL,config.ssl_options
    end
  end
end

# Settings in config/environments/* take precedence over those specified here.
# Application configuration should go into files in config/initializers
# -- all .rb files in that directory are automatically loaded.