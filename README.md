# Stripe Checkout Foundations

[Stripe Checkout](https://stripe.com/docs/payments/checkout) creates a secure, Stripe-hosted payment page that lets you collect payments quickly. It works across devices and can help increase your conversion. Checkout makes it easy to build a first-class payments experience. 

## About this Repo
This repo corresponds to the Checkout integration built in the [Checkout 101 video series](https://www.youtube.com/watch?v=bvQVPoRvbj0&list=PLy1nL-pvL2M5cO2i3lSYtwyqZh3EeGR9L).  The initial code is the code provided by the [Integration Builder](https://www.youtube.com/watch?v=bvQVPoRvbj0&list=PLy1nL-pvL2M5cO2i3lSYtwyqZh3EeGR9L). 

This repo differs slightly from the Integration Builder code:  

- The hard coded API key has been replaced with an environment variable.
- Calls to `Stripe.set_app_info` and `Stripe.api_version` have been added to `server.rb`.

## Running the code
1. Rename or copy  `.env.example` to `.env` and set `STRIPE_SECRET_KEY` to your test secret API key.   

2. Build the server

~~~
bundle install
~~~

3. Run the server

~~~
ruby server.rb
~~~

4. Visit [http://localhost:4242/checkout.html](http://localhost:4242/checkout.html)

## Get support

If you found a bug or want to suggest a new [feature/use case/sample], please [file an issue](../../issues).

If you have questions, comments, or need help with code, we're here to help:
- on [Discord](https://stripe.com/go/developer-chat)
- on Twitter at [@StripeDev](https://twitter.com/StripeDev)
- on Stack Overflow at the [stripe-payments](https://stackoverflow.com/tags/stripe-payments/info) tag
- by [email](mailto:support+github@stripe.com)

Sign up to [stay updated with developer news](https://go.stripe.global/dev-digest).

## Credits
Photography credit for [box of chocolates](https://unsplash.com/photos/6nQS4pJfdRQ): Louis Mornaud
