module GFavLang
  class Http

    NEXT_REG = /(\d*)>; rel=\"next\"/
    BASE_URI = 'https://api.github.com'

    def initialize(collection)
      @collection = collection
    end

    def get(path)
      page = 1
      begin
        response = _get(path, page)
        raise BadRequestError if response.code.to_i != 200
        @collection.insert(JSON.parse(response.body))
        next_loop = response['link'].to_s.match(NEXT_REG)
        page = next_loop[1].to_i if next_loop
      end while(next_loop)
    end

    private

    def _get(path, page)
      uri = URI("#{BASE_URI}#{path}")
      params = { page: page }
      uri.query = URI.encode_www_form(params)
      Net::HTTP.get_response(uri)
    end
  end
end
