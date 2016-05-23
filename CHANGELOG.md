## GoogleSuggest 0.1.0

* `GoogleSuggest.suggest_for` supports `region` [#2](https://github.com/satoryu/google_suggest/issues/2)
  The class method allows users to choose their regions by passing `region` option to it like
  `GoogleSuggest.suggest_for 'foo', region: 'jp'`. You would get different results and  different order.
  @imargonis, Thank you for proposing your idea.

* Renamed `GoogleSuggest::Configure` with `GoogleSuggest::Configuration`
