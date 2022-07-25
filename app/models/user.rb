class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :payment
  accepts_nested_attributes_for :payment

  enum account_type: { free: 0, premium: 1, amaze: 2 }, _prefix: true

  has_many :images, dependent: :destroy

  after_create do
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end
end
