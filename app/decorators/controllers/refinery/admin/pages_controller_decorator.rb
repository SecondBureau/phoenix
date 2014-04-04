Refinery::Admin::PagesController.class_eval do
  after_filter :expire_page, :only => :update
  private
  
  def expire_page
    options = {:controller => '/refinery/pages'}
    options[:action] = @page.menu_match.eql?("^/$") ? 'home' : 'show'
    options[:locale] = params[:switch_locale] unless params[:switch_locale].eql?(I18n.default_locale.to_s)
    expire_action options
  end
end


