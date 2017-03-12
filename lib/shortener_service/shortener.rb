module ShortenerService
  class Shortener
    PREFIX = 'abc'

    def index(short_url)
      short_url.slice!(PREFIX)
      short_url.to_i(36)
    end

    def short_url(url)
      @url = url
      index = create_and_store unless index = already_stored?
      PREFIX + index.to_s(36)
    end

    def prepare_url(body)
      JSON.parse(body)['url'].tap do |url|
        url.prepend('http://') unless (url =~ /\Ahttps?:\/\//) == 0
      end
    end

    private

    def create_and_store
      GlobalStorage.size.tap do |index|
        GlobalStorage[index] = @url
        DigestTable[url_hash] = index
      end
    end

    def already_stored?
      DigestTable[url_hash]
    end

    def url_hash
      @url_hash ||= Digest::MD5.hexdigest(@url)
    end
  end
end