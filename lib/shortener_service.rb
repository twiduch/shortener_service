require 'json'
require 'sinatra'
require 'digest'

module ShortenerService
  Dir["#{File.dirname(__FILE__)}/shortener_service/**/*.rb"].each { |f| require(f) }

  # Can't be run on server with multiple processes
  GlobalStorage = []
  DigestTable = {}

  class ShortenerService < Sinatra::Base
    enable  :logging
    disable :sessions
    set :views, "#{settings.root}/shortener_service/views"
    set :public_folder, "#{settings.root}/shortener_service/public"

    get '/front' do
    	haml :index, :format => :html5
    end

    get '/:short_url' do
      index = Shortener.new.index(params['short_url'])
      url = GlobalStorage[index]
      redirect (url ? url : '/front'), 301
    end

    post '/' do
      shortener = Shortener.new
      url = shortener.prepare_url(request.body.read)
      short_url = shortener.short_url(url)

      content_type :json
        { :short_url => short_url,:url => url }.to_json
    end
  end
end