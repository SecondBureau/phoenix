source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '3.2.14'

group :development, :test do
  gem 'sqlite3'
  gem 'pry-rails'
  gem 'pry-debugger'
end

group :production do
  gem 'pg'
  gem 'fog'
  gem 'rails_12factor'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem "rails_strap", path: "vendor/rails_strap-1.0.3"

# Optimizations
gem 'thin'
gem 'rack-cache'
gem 'dalli'
gem 'kgio'


# Refinery CMS
gem 'refinerycms', '~> 2.0.0'
gem 'refinerycms-i18n',   '~> 2.0.0'
gem 'refinerycms-blog', '~> 2.0.0'
gem 'refinerycms-inquiries', '~> 2.0.0'
