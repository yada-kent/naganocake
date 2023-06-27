class Item < ApplicationRecord
   with_options presence: true do
   validates :name
   validates :introduction
   validates :price
 end
end
