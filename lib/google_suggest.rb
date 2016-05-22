# encoding: utf-8

require 'uri'
require 'nokogiri'
require 'net/http'
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

  def self.suggest_for(keyword)
    self.new.suggest_for(keyword)
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
    xml = Nokogiri::XML(res.body.to_s)
    suggestions = []
    xml.css('toplevel CompleteSuggestion').each do |node|
      suggest = {}
      node.children.each do |child|
        suggest[child.name] = (child['data'] || child['int'].to_i)
      end
      if suggest['suggestion'] and not suggest['suggestion'].valid_encoding?
        suggest['suggestion'].force_encoding('Shift_JIS').encode!('UTF-8')
      end
      suggestions << suggest
    end
    return suggestions
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
end
