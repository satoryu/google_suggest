# encoding: utf-8

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

require File.expand_path(File.join(File.dirname(__FILE__), '..',
                           'lib', 'google_suggest'))

RSpec.configure do |c|
  c.mock_with :rspec
end
