require 'uri'
require 'net/http'
require 'google_suggest/configuration'
require 'google_suggest/region'
require 'google_suggest/parser'

class GoogleSuggest
  attr_accessor :home_language
  attr_accessor :region
  attr_accessor :proxy

  def self.configure
    yield configuration if block_given?

    configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.suggest_for(keyword, options = {})
    new(options).suggest_for(keyword)
  end

  def initialize(options = {})
    @home_language = self.class.configuration.home_language
    @proxy = self.class.configuration.proxy
    @region = options[:region] || self.class.configure.region
  end

  def suggest_for(keyword)
    query = {
      output: 'toolbar',
      hl: home_language,
      q: keyword
    }

    res = http_get('/complete/search', query)

    parse(res.body.to_s)
  end

  private

  def http
    if @proxy
      proxy_url = URI.parse(@proxy)
      http_class = Net::HTTP.Proxy(proxy_url.host, proxy_url.port)
    else
      http_class = Net::HTTP
    end
    http_class.new(google_host)
  end

  def http_get(path, query)
    path = path + '?' + URI.encode_www_form(query)
    req = Net::HTTP::Get.new(path)
    http.request(req)
  end

  def google_host
    Region.host_for(region)
  end

  def parse(doc)
    doc = doc.encode('UTF-8', 'Shift_JIS') unless doc.valid_encoding?
    parser = Parser.new(doc)
    suggestions = parser.parse('/toplevel/CompleteSuggestion/suggestion')

    suggestions
  end
end
