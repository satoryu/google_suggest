require 'uri'
require 'net/http'
require 'rexml/document'
require 'google_suggest/configuration'
require 'google_suggest/region'

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

  def self.suggest_for(keyword, options={})
    self.new(options).suggest_for(keyword)
  end

  def initialize(options={})
    @home_language = self.class.configuration.home_language
    @proxy = self.class.configuration.proxy
    @region = options[:region] || self.class.configure.region
  end

  def suggest_for(keyword)
    query = {:output => 'toolbar',
             :hl => self.home_language,
             :q => URI.encode(keyword)}

    res = http_get('/complete/search', query)

    return parse(res.body.to_s)
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
    path = path + '?' + query.map{|k,v| "#{k}=#{v}"}.join('&')
    req = Net::HTTP::Get.new(path)
    http.request(req)
  end

  def google_host
    Region.host_for(region)
  end

  def parse(doc)
    xml = REXML::Document.new(doc)
    suggestions = REXML::XPath.match(xml, '/toplevel/CompleteSuggestion/suggestion').each_with_object([]) do |suggest, res|
      data = suggest.attribute('data').value
      if data and !data.valid_encoding?
        data.force_encoding('Shift_JIS').encode!('UTF-8')
      end
      res << data
    end

    return suggestions
  end
end
