class Item < ApplicationRecord
   with_options presence: true do
   validates :name
   validates :introduction
   validates :price
   validates :image
   end

   has_one_attached :image
   has_many :cart_items, dependent: :destroy


end
