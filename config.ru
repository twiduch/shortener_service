require_relative 'lib/shortener_service'
require 'rack/cors'

# Cross Origin requests
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :any
  end
end

run ShortenerService::ShortenerService