require 'rake'

Gem::Specification.new do |spec|
  spec.name = 'google_suggest'
  spec.required_ruby_version = '>= 1.8.7'
  spec.summary = 'A gem which allows us to retrieve suggest words from Google in your Ruby Code.'
  spec.version = '0.0.3'
  spec.author  = 'Tatsuya Sato'
  spec.email   = 'satoryu.1981@gmail.com'
  spec.homepage = 'http://github.com/satoryu/google_suggest/'
  spec.files = FileList[%w[
    [A-Z]*
    lib/**/*.rb
    spec/**/*
  ]]
  spec.add_runtime_dependency "nokogiri", '~> 1.6.0'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14.0'
end

