require 'spec_helper'

describe GoogleSuggest::Region do
  describe '.host_for' do
    subject { GoogleSuggest::Region.host_for(region_code) }

    context 'when giving nil as region code' do
      let(:region_code) { nil }

      it 'should be default host "www.google.com"' do
        should be_eql('www.google.com')
      end
    end
    context 'when giving a valid region code like "ac"' do
      let(:region_code) { 'ac' }

      it 'shoud be the google host for the given region' do
        should be_eql('www.google.ac')
      end
    end
  end
end
