if ENV['CI']
  require 'simplecov'

  SimpleCov.start do
    add_filter '/spec/'
  end
end

require File.expand_path(File.join(__dir__, '..', 'lib', 'google_suggest'))
require 'webmock/rspec'

RSpec.configure do |c|
  c.mock_with :rspec

  c.before :suite do
    WebMock.disable_net_connect!
  end
end
