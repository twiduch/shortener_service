require 'spec_helper'

describe ShortenerService do
  let(:service) { ShortenerService.new }
  let(:url) { 'http://www.farmdrop.com' }
  let(:json) { "{\"url\":\"https://www.farmdrop.com/london/bakery\"}" }
  let(:response) {
    "{\"short_url\":\"abc0\",\"url\":\"https://www.farmdrop.com/london/bakery\"}"
  }

  before(:each) do
    GlobalStorage.clear
    DigestTable.clear
  end

  it 'shortens url' do
    post('/', json, { "CONTENT_TYPE" => "application/json" })
    expect(last_response.body).to eq response
  end

  it 'redirects to frontend if short url does not exist' do
    get '/abc0'
    expect(last_response.redirect?).to be_truthy
    follow_redirect!
    expect(last_request.path).to eq '/front'
  end

  it 'redirects to proper url' do
    Shortener.new.short_url(url)
    get '/abc0'
    expect(last_response.redirect?).to be_truthy
    follow_redirect!
    expect(last_request.base_url).to eq "http://www.farmdrop.com"
  end

  it 'renders frontend' do
    get '/front'
    expect(last_response.body).to include("input name='url' type='text'")
  end
end