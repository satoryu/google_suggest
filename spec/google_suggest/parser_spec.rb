require 'spec_helper'

describe GoogleSuggest::Parser do
  let(:doc) {
    <<-DOC
    <?xml version="1.0"?>
    <toplevel>
      <CompleteSuggestion>
        <suggestion data="google translate"/>
      </CompleteSuggestion>
    </toplevel>
    DOC
  }

  describe '#parse' do
    it 'returns nodes matched with a given path as an array' do
      parser = GoogleSuggest::Parser.new(doc)
      actual = parser.parse('/toplevel/CompleteSuggestion/suggestion')

      expect(actual).to match_array(['google translate'])
    end

    context 'When no nodes matche with a given path' do
      it 'returns empty array' do
        parser = GoogleSuggest::Parser.new(doc)
        actual = parser.parse('/no/matched/path')

        expect(actual).to be_empty
      end
    end
  end
end