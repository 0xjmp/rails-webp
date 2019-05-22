# Rails::Webp

Create webp copies of your image assets the easy way using [minimagick](https://github.com/minimagick/minimagick)!

## Installation

Before installing, make sure you have [ImageMagick](https://imagemagick.org/script/download.php) installed on your host.

Add this line to your application's Gemfile:

```ruby
gem 'rails-webp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails-webp

## Usage

This gem is intended to be used as a post processor step in your asset pipeline:
```
bundle exec rake assets:precompile
```

You can configure options passed to ImageMagick in an initializer:

`config/initializers/webp.rb`:

```
Rails::WebP.encode_options = { quality: 80, lossless: true, method: 6, alpha_filtering: 2, alpha_compression: 0, alpha_quality: 100 }
```

A comprehensive list of options can be found [here](https://imagemagick.org/script/webp.php).

**Note:** a digest is included in the processed webp image's file name. This digest is compared for each time compilation occurs.
By default, `rails-webp` will only process images that have a mismatched digest (AKA hash of source image contents).
If you wish to force webp processing:

```
Rails::WebP.force = true # default: false
```


## Motivations for this gem

In my experience, the existing gems for processing webp images in the Rails Asset Pipeline made questionable assumptions.
More importantly, I could not use the native libraries used by those gems in my team's acceptance/production environment.
ImageMagick was an easy choice for this reason because it's widely implemented, used, and understood (my opinion).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jakenberg/rails-webp. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rails::Webp project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jakenberg/rails-webp/blob/master/CODE_OF_CONDUCT.md).
