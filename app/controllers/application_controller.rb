class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale

  private
  
  def set_locale
    return unless new_browser? && frontend?
    locale =  set_locale_from_param || set_locale_from_tld || set_locale_from_browser ||  Refinery::I18n.default_frontend_locale
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
  
  def frontend?
    logger.debug "* Request Path: '#{request.path}'"
    !request.path.split('/')[1].eql?('refinery')
  end
  
  def set_locale_from_param
    logger.debug "* Params: '#{params[:locale]}', '#{params[:force_locale]}'"
    parsed_locale = params[:locale]
    force_locale = params[:force_locale]
    if force_locale.nil?
      (!parsed_locale.nil? && !parsed_locale.eql?(Refinery::I18n.default_frontend_locale) && Refinery::I18n.frontend_locales.include?(parsed_locale)) ? parsed_locale  : nil
    else
      Refinery::I18n.frontend_locales.include?(force_locale.to_sym) ? force_locale.to_sym  : nil
    end
  end
  
  def set_locale_from_tld
    logger.debug "* Host: '#{request.host}'"
    parsed_locale = request.host.split('.').last.to_sym
    Refinery::I18n.frontend_locales.include?(parsed_locale) ? parsed_locale  : nil
  end
  
  def set_locale_from_browser
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    begin
      parsed_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      logger.debug "* Accept-Language: parsed_locale #{parsed_locale}"
      Refinery::I18n.frontend_locales.include?(parsed_locale.to_sym) ? parsed_locale.to_sym  : nil
    rescue
    end
  end
  
end
