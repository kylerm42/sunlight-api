# Sunlight Api

The [Sunlight Foundation](http://sunlightfoundation.com/about/) is a nonprofit, nonpartisan group that "advocates for open government globally and uses technology to make government more accountable to all." They provide multiple great APIs for political data, and this gem provides a **clean, simple wrapper for the Sunlight Foundation APIs**. It's currently a work in progress, and will be updated frequently to support more of their APIs.

## Usage

#### Congress API
##### Legislators

To find the representatives for a certain location
```ruby
Sunlight::Congress::Legislator.locate_by_zip(23219)
Sunlight::Congress::Legislator.locate(zip: 23219)
Sunlight::Congress::Legislator.locate(latitude: 37.538821, longitude: -77.433574)
Sunlight::Congress::Legislator.locate(address: '1000 Bank St, Richmond, VA')
Sunlight::Congress::Legislator.locate('37.538821, -77.433574') # Not recommended
Sunlight::Congress::Legislator.locate('1000 Bank St, Richmond, VA')
```
A zip code may intersect with multiple congressional districts, so to find all the legislators in a certain zip code, use the ```locate_by_zip``` method. The ```locate``` method can take parameters as either a string or hash of options (recommended for latitude/longitude or zip codes). All string queries will be geocoded into lat/long pairs.

To find a specific representative, you have multiple options for searching
```ruby
Sunlight::Congress::Legislator.find('Warner') # Searches on the first, middle, last, and nickname fields
Sunlight::Congress::Legislator.find(gender: 'F', party: 'R') # All current female, republican legislators
Sunlight::Congress::Legislator.find(gender: 'F', party: 'R', all_legislators: true) # All past and present female, republican legislators
Sunlight::Congress::Legislator.find_by_state_rank('senior') # All legislators with a senior rank
```
The ```find``` method accepts either a string or hash of parameters. Strings will only query the first, middle, last, and nicknames of legislators. You can also ```find_by_``` certain attributes. To see a list of accepted attributes (also applies to parameters passed into the ```find``` method), [look here](https://sunlightlabs.github.io/congress/legislators.html)

Legislator location and searching methods return an array of ```Legislator``` objects
```ruby
legislators = Sunlight::Congress::Legislator.find(gender: 'F', party: 'R')
legislators #=> [#<Sunlight::Congress::Legislator:0x007f8fb7834b88 @bioguide_id="E000295", @birthday="1970-07-01", @chamber="senate"...>, #<Sunlight::Congress::Legislator:0x007f8fb58b15e0 @bioguide_id="C001105", @birthday="1959-06-30", @chamber="house"...>, ...]
legislators[0].office #=> "825 B&c Hart Senate Office Building"
```


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sunlight-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sunlight-api

Get [your API key](http://sunlightfoundation.com/api/accounts/register/) and run:

```ruby
Sunlight::Base.api_key = 'your_api_key'
```

## Contributing

1. Fork it ( https://github.com/kylerm42/sunlight-api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
