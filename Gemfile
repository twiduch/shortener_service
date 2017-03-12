# frozen_string_literal: true
source 'https://rubygems.org'

# Allow cross-origin incoming HTTP requests
gem 'rack-cors', require: 'rack/cors'
gem 'sinatra'
gem 'haml'

group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
end

group :test do
  gem 'rspec'
  gem 'simplecov'
  gem 'rack-test'
end

group :development do
  gem 'guard-rspec'
end
