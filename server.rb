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
      adjustable_quantity: {
        enabled: true,
        maximum: 10,
      },
    },
    {
      # Optional 2nd line item. Be sure to replace the price id
      # with a price id of a product in your account.
      price: 'price_1KO6TPCVE8DvCN2ecHyva8ez',
      adjustable_quantity: {
        enabled: true,
        maximum: 10,
        minimum: 3
      },
      quantity: 5,
    }],
    mode: 'payment',
    success_url: YOUR_DOMAIN + '/success.html?session_id={CHECKOUT_SESSION_ID}',
    cancel_url: YOUR_DOMAIN + '/cancel.html?session_id={CHECKOUT_SESSION_ID}',
  })
  redirect session.url, 303
end

get '/order-info' do
  session = Stripe::Checkout::Session.retrieve(params[:session_id])
  customer = Stripe::Customer.retrieve(session.customer)
  line_items = Stripe::Checkout::Session.list_line_items(session.id, {limit: 100}) 
  {
    session: session,
    customer: customer,
    line_items: line_items
  }.to_json
end

post '/return-to-checkout' do
  session = Stripe::Checkout::Session.retrieve(params[:session_id])
  redirect session.url, 303
end

post '/webhook' do
  event = nil
  begin
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    payload = request.body.read
    event = Stripe::Webhook.construct_event(payload, 
      sig_header, ENV['STRIPE_WEBHOOK_SECRET'])
  rescue JSON::ParserError => e
    #Invalid payload
    return status 400
  rescue Stripe::SignatureVerificationError => e
    #invalid signature
    return status 400
  end
  puts "received event type: #{event.type}"

  case event.type
  when 'checkout.session.completed'
    checkout_session = event.data.object
    # Save an order in your database, marked as 'awaiting payment'
    create_order(checkout_session)

    # Check if the order is already paid (for example, from a card payment)
    #
    # A delayed notification payment will have an `unpaid` status, as
    # you're still waiting for funds to be transferred from the customer's
    # account.
    if checkout_session.payment_status == 'paid'
      fulfill_order(checkout_session)
    end
  when 'checkout.session.async_payment_succeeded'
    checkout_session = event.data.object

    # Fulfill the purchase...
    fulfill_order(checkout_session)
  when 'checkout.session.async_payment_failed'
    checkout_session = event.data.object

    # Send an email to the customer asking them to retry their order
    email_customer_about_failed_payment(checkout_session)
  else
    puts "unhandled event type: #{event.type}"
  end
  return status 200
end

def fulfill_order(checkout_session)
  puts "Fulfilling order for #{checkout_session.inspect}"
  line_items = Stripe::Checkout::Session.list_line_items(checkout_session.id, {limit: 100})
  puts "Line items for order #{line_items.data.inspect}"
end

def create_order(checkout_session)
  # TODO: fill in with your own logic
  puts "Creating order for #{checkout_session.inspect}"
end

def email_customer_about_failed_payment(checkout_session)
  # TODO: fill in with your own logic
  puts "Emailing customer about payment failure for: #{checkout_session.inspect}"
end
