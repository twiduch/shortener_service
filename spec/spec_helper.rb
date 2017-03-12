# frozen_string_literal: true
require 'rack/test'
require 'rspec'
require_relative '../lib/shortener_service'
include ShortenerService

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() ShortenerService::ShortenerService end
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.color = true
end
