# FindDuplicates

This is home to the find_duplicates GEM.

Use it to add methods to ActiveRecord models, that allow to find rows with duplicate values in certain columns. For example, find all users with the same first name, or find all items with the same price as a specific item.

Just add 'find_duplicates' to your Gemfile, and you automatically enhance your AR models functionality.

## Installation

Add this line to your application's Gemfile:

    gem 'find_duplicates'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install find_duplicates

## Usage

Given an AR model, for example User, with 'first_name' and 'last_name' fields:
```ruby
class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name
end

> @user1 = User.create first_name: 'Adam', last_name: 'Klein'
> @user2 = User.create first_name: 'Calvin', last_name: 'Klein'
> @user3 = User.create first_name: 'Adam', last_name: 'Sandler'
```

class methods:
```ruby
> User.duplicates(:first_name)          # => [@user1, @user3]
> User.duplicates(:last_name)           # => [@user1, @user2]
```

instance methods:
```ruby
> @user1.duplicate?(:first_name)             # => true
> @user1.duplicates(:first_name)             # => [@user3]
> @user1.duplicates_with_self(:last_name)    # => [@user1, @user2]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
