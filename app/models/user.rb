class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :payment
  accepts_nested_attributes_for :payment

  enum account_type: { free: 0, premium: 1, amaze: 2 }, _prefix: true
end
