class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
   validates :last_name, :first_name
   end


  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
end
