module GFavLang
  class User

    def self.favourite_language(username)
      result = repositories(username)
      language_hash = result.collection.inject(Hash.new(0)) { |h, e|
        h[e.language] += 1 if e.language
        h
      }.sort_by {|k,v| -v}.to_h
      language_hash.keys.first
    end

    def self.repositories(username)
      collection = Collection.new(Repository)
      Http.new(collection).get("/users/#{username}/repos")
      collection
    end
  end
end
