require 'omniauth/strategies/google_oauth2'

Rails.application.config.middleware.use OmniAuth::Builder do
    config = Rails.application.config.x.settings["oauth2"]
  
    provider :google_oauth2, "client-id", "client-secret", image_size: 150
end