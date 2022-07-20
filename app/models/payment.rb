class Payment < ActiveRecord::Base
  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year
  belongs_to :user

  def self.month_options
    Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1] }
  end

  def self.year_options
    (Date.today.year..(Date.today.year+10)).to_a
  end

  def process_payment
    customer = Stripe::Customer.create(email: email, card: token)

    # Stripe::Charge.create customer: customer.id, 
    #                       amount: 1000,
    #                       description: 'Premium',
    #                       currency: 'usd'

    # @session = Stripe::Checkout::Session.create({ 
    #   customer: customer.id,
    #   payment_method_types: ['card'],
    #   line_items: [{ price: 'price_1LLAqALkLgFuVfHBhi0kie6x', quantity: 1 }],
    #   allow_promotion_codes: true,
    #   mode: 'payment',
    #   success_url: root_url + "?session)id={CHECKOUT_SESSION_ID}",
    #   cancel_url: root_url,
    #   })
    #   redirect_to @session.url
  end
end
