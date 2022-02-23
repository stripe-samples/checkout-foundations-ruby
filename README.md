# Stripe Checkout Foundations

[Stripe Checkout](https://stripe.com/docs/payments/checkout) creates a secure, Stripe-hosted payment page that lets you collect payments quickly. It works across devices and can help increase your conversion. Checkout makes it easy to build a first-class payments experience. 

## About this Repo
This repo corresponds to the Checkout integration built in the [Checkout 101 video series](https://www.youtube.com/watch?v=bvQVPoRvbj0&list=PLy1nL-pvL2M5cO2i3lSYtwyqZh3EeGR9L).  The initial code is the code provided by the [Checkout Quickstart](https://stripe.com/docs/checkout/quickstart) [Integration Builder](https://www.youtube.com/watch?v=bvQVPoRvbj0&list=PLy1nL-pvL2M5cO2i3lSYtwyqZh3EeGR9L). 

This repo differs slightly from the Integration Builder code:  

- The hard coded API key has been replaced with an environment variable.
- Calls to `Stripe.set_app_info` and `Stripe.api_version` have been added to `server.rb`.

## Running the code
1. Rename or copy  `.env.example` to `.env` and set `STRIPE_SECRET_KEY` to your test secret API key.   
2. Update the price id used in the `Stripe::Checkout::Session.create` in server.rb
3. Build the server

~~~
bundle install
~~~

4. Run the server

~~~
ruby server.rb
~~~

5. Visit [http://localhost:4242/checkout.html](http://localhost:4242/checkout.html) to start the Checkout flow. 


## Pull requests corresponding to Checkout 101 episodes
You can see the code shown in each 101 episode by video by viewing the corresponding pull request: 

1. [Getting started wtih a Payment Link](https://www.youtube.com/watch?v=GdnUvshUqbE): A no code way to get up and running quickly with a Checkout (no code)
2. [Accept a payment with Checkout and the integration builder](https://www.youtube.com/watch?v=bvQVPoRvbj0): Use the [Checkout Quickstart Integration Builder](https://stripe.com/docs/payments/quickstart) to get up and running quickly with Checkout (initial commit of repo)
3. [Build notifications into Checkout](https://www.youtube.com/watch?v=EaX444Fe2Tk): Add a webhook handler to your Checkout integration so you know when you've gotten paid and can fulfill the order.  [PR](https://github.com/stripe-samples/checkout-foundations-ruby/pull/1)
4. [Build a customer order confirmation page with Checkout](https://www.youtube.com/watch?v=COeMEHKbECw): Use the Checkout Session ID to look up order information after the customer has completed their purchase to display on the success page.  Allow your customers to return to their Checkout session from the cancel page. [PR](https://github.com/stripe-samples/checkout-foundations-ruby/pull/2)
5. Add support for adjustable quantities: Let your customer adjust their order during Checkout.  Display the total price and quantities for each line item purchased on the success page.  [PR](https://github.com/stripe-samples/checkout-foundations-ruby/pull/3)
6. Recover abandoned carts: Configure Checkout to generate a new session when the original session is abandoned by the customer and expires.  Collect consent to send promotional emails and listen for session expired events to know when to reach out to encourage a customer to complete their purchase. [PR](https://github.com/stripe-samples/checkout-foundations-ruby/pull/4)


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
