require 'rexml/document'

class GoogleSuggest
  class Parser
    def initialize(document)
      @document = REXML::Document.new(document)
    end

    def parse(path)
      REXML::XPath.match(@document, path).map do |node|
        node.attribute('data').value
      end
    end
  end
end