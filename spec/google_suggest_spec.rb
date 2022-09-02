require 'spec_helper'

describe GoogleSuggest do
  describe '.new' do
    let(:args) { {} }
    let(:google_suggest) { GoogleSuggest.new(args) }

    subject { google_suggest }

    describe '#home_language' do
      subject { super().home_language }
      it { is_expected.to be_eql 'en' }
    end

    describe '#proxy' do
      subject { super().proxy }
      it { is_expected.to be_nil }
    end

    context 'when giving region option' do
      let(:args) { { region: 'ac' } }

      describe '#home_language' do
        subject { super().home_language }
        it { is_expected.to be_eql 'en' }
      end
    end
  end

  describe '.suggest_for' do
    let(:suggestions) { GoogleSuggest.suggest_for('google') }

    before do
      stub_request(:get, 'http://www.google.com/complete/search')
        .with(query: { hl: 'en', output: 'toolbar', q: 'google' })
        .to_return(body: File.read(File.join(File.dirname(__FILE__), 'sample_us.xml')))
    end

    it do
      expect(suggestions.size).to be 10
    end

    context 'When passing Hash as options' do
      specify 'should initialize new object with the options.' do
        obj = double(:google_suggest)
        expect(obj).to receive(:suggest_for).with('google')
        expect(GoogleSuggest).to receive(:new).with({region: 'jp'}).and_return(obj)

        GoogleSuggest.suggest_for('google', region: 'jp')
      end
    end
  end

  describe '.configure' do
    context 'When called without block' do
      before do
        @configure = GoogleSuggest.configure
        @configure.home_language = 'ja'
        @configure.region = 'ac'
        @configure.proxy = 'http://proxy.example.com'
      end

      subject { GoogleSuggest.new }

      describe '#home_language' do
        subject { super().home_language }
        it { is_expected.to be_eql 'ja' }
      end

      describe '#region' do
        subject { super().region }
        it { is_expected.to be_eql 'ac' }
      end

      describe '#proxy' do
        subject { super().proxy }
        it { is_expected.to be_eql 'http://proxy.example.com' }
      end
    end
    context 'When called with given block' do
      before do
        GoogleSuggest.configure do |c|
          c.home_language = 'us'
          c.proxy = 'http://proxy.example.com'
        end
      end

      subject { GoogleSuggest.new }

      describe '#home_language' do
        subject { super().home_language }
        it { is_expected.to be_eql 'us' }
      end

      describe '#proxy' do
        subject { super().proxy }
        it { is_expected.to be_eql 'http://proxy.example.com' }
      end
    end
  end

  describe '#suggest_for' do
    before :all do
      GoogleSuggest.configure do |c|
        c.home_language = 'us'
        c.region = :com
      end
    end

    let(:google_suggest) { GoogleSuggest.new }
    let(:suggestions) { google_suggest.suggest_for('google') }

    before do
      stub_request(:get, 'http://www.google.com/complete/search')
        .with(query: { hl: 'us', output: 'toolbar', q: 'google'})
        .and_return(body: File.read(File.join(__dir__, 'sample_us.xml')))
    end

    it do
      expect(suggestions.size).to eq(10)
    end

    it 'all suggestions should have the value of the key \'suggest\' 'do
      expect(suggestions).to be_all do |suggest|
        not suggest.nil?
      end
    end
  end
  describe '#suggest_for with home language \'ja\'' do
    before :all do
      GoogleSuggest.configure do |c|
        c.home_language = 'ja'
        c.region = :com
      end
    end

    let(:google_suggest) { GoogleSuggest.new }

    before do
      stub_request(:get, 'http://www.google.com/complete/search')
        .with(query: { hl: 'ja', output: 'toolbar', q: 'グーグル' })
        .to_return(body: File.read(File.join(File.dirname(__FILE__), 'sample_ja.xml')))
    end

    subject { google_suggest.suggest_for('グーグル').shift }

    describe '#encoding' do
      subject { super().encoding }

      it { is_expected.to be Encoding.find('UTF-8') }
    end

    it { is_expected.to be_valid_encoding }
  end
end
