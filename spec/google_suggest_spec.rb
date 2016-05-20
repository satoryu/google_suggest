# encoding: utf-8
require 'spec_helper'

describe GoogleSuggest do
  context "default settiong" do
    subject { GoogleSuggest.new }

    its(:home_language) { should be_eql 'en' }
    its(:proxy) { should be_nil }
  end

  context "Class Methods" do
    before do
      google_suggest = GoogleSuggest.new
      res = Object.new
      allow(res).to receive(:body) do
        doc = nil
        File.open(File.join(File.dirname(__FILE__), 'sample_us.xml')) do |f|
          doc = f.read
        end
        doc
      end
      allow(google_suggest).to receive(:http_get) { res }
      suggestions = google_suggest.suggest_for('google')
      allow(GoogleSuggest).to receive(:new).and_return { double('google_suggest', :suggest_for => suggestions) }

      @suggestions = GoogleSuggest.suggest_for('google')
    end
     
    it do 
      @suggestions.size.should be 10
    end
    it do
      @suggestions.should be_all do
      end
    end
  end

  describe GoogleSuggest::Configuration do
    context "#configure called without block" do
      before do
        @configure = GoogleSuggest.configure
        @configure.home_language = 'ja'
        @configure.proxy = 'http://proxy.example.com'
      end
      subject { GoogleSuggest.new }
      its(:home_language) { should be_eql 'ja' }
      its(:proxy) { should be_eql 'http://proxy.example.com' }
    end
    context "#configure called and given block" do
      before do
        GoogleSuggest.configure do |c|
          c.home_language = 'us'
          c.proxy = 'http://proxy.example.com'
        end
      end
      subject { GoogleSuggest.new }
      its(:home_language) { should be_eql 'us' }
      its(:proxy) { should be_eql 'http://proxy.example.com' }
    end
  end

  context "#suggest_from method" do
    before :all do
      GoogleSuggest.configure do |c|
        c.home_language = 'us'
      end
    end

    before do
      @google_suggest = GoogleSuggest.new
      res = double(:response)
      allow(res).to receive(:body) do
        doc = nil
        File.open(File.join(File.dirname(__FILE__), 'sample_us.xml')) do |f|
          doc = f.read
        end
        doc
      end
      allow(@google_suggest).to receive(:http_get) { res }
    end

    it do
      suggestions = @google_suggest.suggest_for 'google'
      suggestions.size.should == 10
    end

    it 'all suggestions should have the value of the key \'suggest\' 'do
      suggestions = @google_suggest.suggest_for 'google'
      suggestions.should be_all do |suggest|
        not suggest['suggest'].nil?
      end
    end


    it 'all suggestions should have the value of the key \'num_queries\' 'do
      suggestions = @google_suggest.suggest_for 'google'
      suggestions.should be_all do |suggest|
        not suggest['num_queries'].nil?
      end
    end
  end
  describe "#suggest_for with home language 'ja'" do
    before :all do
      GoogleSuggest.configure do |c|
        c.home_language = 'ja'
      end
    end

    before do
      @google_suggest = GoogleSuggest.new
      res = Object.new
      allow(res).to receive(:body) do
        doc = nil
        File.open(File.join(File.dirname(__FILE__), 'sample_ja.xml')) do |f|
          doc = f.read
        end
        doc
      end
      allow(@google_suggest).to receive(:http_get) { res }
    end
      subject {@google_suggest.suggest_for('グーグル').shift['suggestion']}

    its(:encoding) { should be Encoding.find("UTF-8") }
    it { should be_valid_encoding }
  end
end
