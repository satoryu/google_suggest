# encoding: utf-8

if ENV['CI']
  require 'simplecov'

  SimpleCov.start do
    add_filter "/spec/"
  end
end

require File.expand_path(File.join(File.dirname(__FILE__), '..',
                           'lib', 'google_suggest'))

RSpec.configure do |c|
  c.mock_with :rspec
end
