class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale

  private
  
  def set_locale
    return unless new_browser?
    locale = set_locale_from_param || set_locale_from_tld || set_locale_from_browser || Refinery::I18n.default_frontend_locale
    logger.debug "* Locale set to '#{locale}'"
    session[:locale] = locale
    redirect_to refinery.url_for(:locale => locale) unless locale.eql?(I18n.locale)
  end
  
  def new_browser?
    begin
      referer = request.referer
      host = request.host
      logger.debug "* referer: '#{referer}', host: '#{host}'"
      referer.nil? && !URI(referer).host.eql?(host)
    rescue
      true
    end
  end
  
  def set_locale_from_param
    logger.debug "* Param: '#{params[:locale]}'"
    parsed_locale = params[:locale]
    (!parsed_locale.nil? && !parsed_locale.eql?(I18n.default_locale) && Refinery::I18n.frontend_locales.include?(parsed_locale)) ? parsed_locale  : nil
  end
  
  def set_locale_from_tld
    logger.debug "* Host: '#{request.host}'"
    parsed_locale = request.host.split('.').last.to_sym
    Refinery::I18n.frontend_locales.include?(parsed_locale) ? parsed_locale  : nil
  end
  
  def set_locale_from_browser
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    parsed_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    begin
      logger.debug "* Accept-Language: parsed_locale #{parsed_locale}"
      Refinery::I18n.frontend_locales.include?(parsed_locale.to_sym) ? parsed_locale.to_sym  : nil
    rescue
    end
  end
  
end
