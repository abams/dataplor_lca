# frozen_string_literal: true

source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

# Use sqlite3 as the database for Active Record
gem 'pg', '~> 1.5', '>= 1.5.6'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
end

group :development do
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end
