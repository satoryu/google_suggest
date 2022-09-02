lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'google_suggest/version'

Gem::Specification.new do |spec|
  spec.name = 'google_suggest'
  spec.required_ruby_version = '>= 2.7.0'
  spec.summary = 'A gem which allows us to retrieve suggest words from Google in your Ruby Code.'
  spec.version = GoogleSuggest::VERSION
  spec.author  = 'Tatsuya Sato'
  spec.email   = 'satoryu.1981@gmail.com'
  spec.homepage = 'http://github.com/satoryu/google_suggest/'
  spec.license = 'MIT'
  spec.files = Dir[
    'lib/**/*.rb',
    '[A-Z]*',
    'spec/**/*'
  ]

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock', '~> 3.11'
end
