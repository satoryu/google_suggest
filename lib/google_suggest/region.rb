class GoogleSuggest
  DEFAULT_GOOGLE_HOST = 'www.google.com'

  class Region
    def self.host_for(region_code)
      case region_code
      when :ac, 'ac'
        'www.google.ac'
      else
        DEFAULT_GOOGLE_HOST
      end
    end
  end
end
