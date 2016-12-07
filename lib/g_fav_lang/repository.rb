module GFavLang
  class Repository
    attr_reader :id, :name, :url, :language

    def initialize(args)
      args.each do |key, value|
        instance_variable_set "@#{key.gsub(' ', '_')}", value
      end
    end
  end
end
