# encoding: utf-8

Refinery::I18n.configure do |config|
  config.enabled = true

  config.default_locale = :fr

  config.current_locale = :fr

  config.default_frontend_locale = :fr

  config.frontend_locales = [:fr, :en]

  config.locales = {:fr=>"Français", :en=>"English"}
end
