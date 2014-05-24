# encoding: utf-8

Refinery::I18n.configure do |config|
  config.enabled = true

  config.default_locale = :en

  config.current_locale = :en

  config.default_frontend_locale = :en

  config.frontend_locales = [:fr, :en, :"zh-CN"]

  config.locales = {:fr=>"Français", :en=>"English", :"zh-CN"=>"简体中文"}
end
