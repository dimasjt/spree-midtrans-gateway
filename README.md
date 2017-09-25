# Midtrans Gateway for Spree

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spree_midtrans_gateway'
```

And then execute:

    $ bundle
* Add new payment method in admin. http://host/admin/payment_methods/new

* Fill form

to get client key and server key https://dashboard.sandbox.midtrans.com/settings/config_info

|Field|Value|
|---|---|
|Provider| Spree::Gateway::MidtransGateway|
|Client Key||
|Server Key||
|Name|string|
|Test Mode|_check_ if use sandbox|

* Setup redirect configuration in Midtrans dashboard
https://dashboard.sandbox.midtrans.com/settings/vtweb_configuration

|Field|Value|
|---|---|
|Payment Notification|http://host.com/payment/midtrans/notifications|
|Finish Redirect|http://host.com/payment/midtrans/succcess|
|Unfinish Redirect|http://host.com/checkout/payment|
|Error Redirect|http://host.com/checkout/payment|

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dimasjt/spree-midtrans-gateway. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Spree::Midtrans::Gateway project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dimasjt/spree-midtrans-gateway/blob/master/CODE_OF_CONDUCT.md).
