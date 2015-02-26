# White Ruby

White makes accepting payments in the Middle East ridiculously easy. Sign up for an account at [whitepayments.com](http://whitepayments.com).

## Getting Started

Using White with your Ruby project is simple. If you're using [bundler](http://bundler.io) (and really, who isn't these days amirite?), you just need to add one line to your `Gemfile`:

```ruby
gem 'white_payments', require: 'white'
```

Now, running `bundle install` will pull the library directly to your local project.

## Using White

You'll need an account with White if you don't already have one (grab one real quick at [whitepayments.com](http://whitepayments.com) and come back .. we'll wait).

Got an account? Great .. let's get busy.

### 1. Initializing White

To get started, you'll need to initialize White with your secret API key. Here's how that looks (we're using a test key, so no real money will be exchanging hands):

```ruby
require 'white'

White.api_key = "test_sec_k_25dd497d7e657bb761ad6"
```

That's it! You probably want to do something with the White object though -- it gets really bored when it doesn't have anything to do. 

Let's run a transaction, shall we.

### 2. Processing a transaction through White

Now, for the fun part. Here's all the code you need to process a transaction with White:

```ruby
White::Charge.create(
    :amount => 5,
    :currency => "aed",
    :card => {
      :number => "4242424242424242",
      :exp_month => 11,
      :exp_year => 2016,
      :cvv => 123
    },
    :description => "Charge for test@example.com"
  )
```

This transaction should be successful since we used the `4242 4242 4242 4242` test credit card. For a complete list of test cards, and their expected output you can check out this link [here](https://whitepayments.com/docs/testing/).

How can you tell that it was successful? Well, if no exception is raised then you're in the clear.

### 3. Handling Errors

Any errors that may occur during a transaction is raised as an Exception. Here's an example of how you can handle errors with White:

```ruby
begin
  # Use White's bindings...
  
rescue White::BankingError => e
  # Since it's a decline, White::BankingError will be caught
  puts "Status is: #{e.http_status}"
  puts "Code is: #{e.code}"
  puts "Message is: #{e.message}"
  
rescue White::RequestError => e
  # Invalid parameters were supplied to White's API

rescue White::AuthenticationError => e
  # There's something wrong with that API key you passed

rescue White::ProcessingError => e
  # There's something wrong on White's end
  
rescue White::WhiteError => e
  # Display a very generic error to the user, and maybe send
  # yourself an email
  
rescue => e
  # Something else happened, completely unrelated to White
end
```

## Testing White
If you're looking to contribute to White, then grab this repo and run `rake` on your local machine to run the unit tests.

## Contributing

Read our [Contributing Guidelines](CONTRIBUTING.md) for details
