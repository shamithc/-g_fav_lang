module GFavLang
  class Collection
    attr_reader :collection

    def initialize(object_class)
      @collection = []
      @object_class = object_class
    end

    def insert(response)
      response.each do |res|
        collection << @object_class.send(:new, res)
      end
    end
  end
end
