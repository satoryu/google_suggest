# ChangeLog

## (Next Release)

* Drop ruby 2.3 from supported ruby versions. [#25](https://github.com/satoryu/google_suggest/pull/25)

## GoogleSuggest 1.0.1

* Drop ruby 2.1 and 2.2 from and add ruby 2.5 supported ruby versions. [#19](https://github.com/satoryu/google_suggest/pull/19)
[#22](https://github.com/satoryu/google_suggest/pull/22)
* Starting use Webmock and RSpec 3.[#15](https://github.com/satoryu/google_suggest/pull/15)[#21](https://github.com/satoryu/google_suggest/pull/21)

## GoogleSuggest 1.0.0

* Removing the dependency on `nokogiri`, use REXML. [#10](https://github.com/satoryu/google_suggest/pull/10)
* Fix `NameError: uninitialized constant GoogleSuggest::Region::DEFAULT_GOOGLE_HOST`. [#11](https://github.com/satoryu/google_suggest/pull/11)
* Allows to get all supported region codes with `GoogleSuggest::Region.codes`. [#14](https://github.com/satoryu/google_suggest/pull/14)

## GoogleSuggest 0.1.0

* `GoogleSuggest.suggest_for` supports `region` [#2](https://github.com/satoryu/google_suggest/issues/2)
  The class method allows users to choose their regions by passing `region` option to it like
  `GoogleSuggest.suggest_for 'foo', region: 'jp'`. You would get different results and  different order.
  @imargonis, Thank you for proposing your idea.

* Renamed `GoogleSuggest::Configure` with `GoogleSuggest::Configuration`
