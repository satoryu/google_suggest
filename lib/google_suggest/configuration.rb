class GoogleSuggest
  class Configuration
    attr_accessor :home_language
    attr_accessor :proxy

    def initialize
      @home_language = 'en'
    end
  end
end
