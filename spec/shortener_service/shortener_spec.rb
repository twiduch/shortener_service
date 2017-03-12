require 'spec_helper'

describe Shortener do
  let(:json1) { "{\"url\":\"https://www.farmdrop.com/london/bakery\"}" }
  let(:json2) { "{\"url\":\"google.com?fd=m\xC3\xB3\xC5\x84&cc='s p a c e'\"}" }
  let(:url) { "https://www.farmdrop.com" }
  let(:shortener) {Shortener.new}

  it 'parses url properly' do
    expect(shortener.prepare_url(json1)).to eq "https://www.farmdrop.com/london/bakery"
    expect(shortener.prepare_url(json2)).to eq "http://google.com?fd=móń&cc='s p a c e'"
  end

  it 'creates proper index for shortened url' do
    expect(shortener.index('abc10')).to eq 36
  end

  it 'stores new url' do
    digest = Digest::MD5.hexdigest(url)
    expect(shortener.short_url(url)).to eq 'abc0'
    expect(GlobalStorage[0]).to eq url
    expect(DigestTable[digest]).to eq 0
  end

  it 'finds existing urls' do
    shortener.short_url(url)
    expect(shortener.short_url(url)).to eq 'abc0'
    expect {shortener.short_url(url)}.not_to change {GlobalStorage.size}
    expect {shortener.short_url(url)}.not_to change {DigestTable.size}
  end
end