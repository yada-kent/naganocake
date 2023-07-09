class Item < ApplicationRecord
   with_options presence: true do
   validates :name
   validates :introduction
   validates :price
   validates :image
   end

   def with_tax_price
      (price * 1.1).floor
   end

   has_one_attached :image
   has_many :cart_items, dependent: :destroy


end
