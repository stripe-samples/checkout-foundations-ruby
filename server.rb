require 'stripe'
require 'sinatra'
require 'dotenv'

Dotenv.load

# For sample support and debugging, not required for production:
Stripe.set_app_info(
  'stripe-samples/checkout-foundations-ruby',
  version: '0.0.1',
  url: 'https://github.com/stripe-samples/checkout-foundations-ruby'
)
Stripe.api_version = '2020-08-27'

# This is your test secret API key.  The Integration Builder in the docs will prefill this for you . 
# For this example we've replaced the hard coded key with an environment variable instead. 
#Stripe.api_key = 'sk_test_XXX'
Stripe.api_key = ENV['STRIPE_SECRET_KEY']
set :static, true
set :port, 4242

YOUR_DOMAIN = 'http://localhost:4242'

post '/create-checkout-session' do
  content_type 'application/json'

  session = Stripe::Checkout::Session.create({
    line_items: [{
      # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
      price: 'price_1KK6xnCVE8DvCN2eDe52K9XF',
      quantity: 1,
    }],
    mode: 'payment',
      success_url: YOUR_DOMAIN + '/success.html',
      cancel_url: YOUR_DOMAIN + '/cancel.html',
  })
  redirect session.url, 303
end
