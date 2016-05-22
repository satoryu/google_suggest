class GoogleSuggest
  class Configuration
    attr_accessor :home_language
    attr_accessor :proxy
    attr_accessor :region

    def initialize
      @home_language = 'en'
      @region = nil
    end
  end
end
