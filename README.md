# GoogleSuggest

[![Gem Version](https://badge.fury.io/rb/google_suggest.svg)](https://badge.fury.io/rb/google_suggest)
[![Build Status](https://travis-ci.org/satoryu/google_suggest.svg?branch=master)](https://travis-ci.org/satoryu/google_suggest)

This gem allows you to access google suggest API in your ruby codes. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'google_suggest'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google_suggest

## Usage

`GoogleSuggest.suggest_for` gives suggestions for a given keyword. 

```ruby
GoogleSuggest.suggest_for 'google'
=> ["google", "google maps", "google translate", "google classroom", "google docs", "google drive", "google earth", "google play", "google scholar", "google slides"]
```

and allows developers to switch the endpoint by specifying `region` option:

```ruby
GoogleSuggest.suggest_for 'google', region: 'jp'
=> ["google", "google maps", "google drive", "google translate", "google scholar", "google docs", "google flights", "google news", "google play", "google earth"]
```

You can get all available region codes by `GoogleSuggest::Region.codes`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/satoryu/google_suggest. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

