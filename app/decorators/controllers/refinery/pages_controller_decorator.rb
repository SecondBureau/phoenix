Refinery::PagesController.class_eval do
  #caches_page :show
  caches_action :home, :index, :if => Proc.new { |c| !local_request? && !refinery_user? } 
  
end