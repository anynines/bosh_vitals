# BoshVitals

TODO: Write a gem description

## Configuration

    cp bin/set_environment.sh bin/environments/set_environment.sh
    # configure threshold values for checks
    vim bin/environments/set_environment.sh

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bosh_vitals'
```

And then execute:

    $ bundle
    $ bundle exec rake install

Or install it yourself as:

    $ gem install bosh_vitals

## Usage

```
source bin/set_environment.sh

# Check all vm vitals for all deployments
bin/check_all_vm_vitals

# Check vitals for a specific deployment
bin/check_vm_vitals <deployment_name>
```

## Return codes

* 0 - OK
* 1 - Warning
* 2 - Critical

## Contributing

1. Fork it ( https://github.com/[my-github-username]/bosh_vitals/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
