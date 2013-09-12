Refinery::PagesController.class_eval do
  #caches_page :show
  caches_action :home, :show
end