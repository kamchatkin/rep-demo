class Shop < ApplicationRecord

  has_and_belongs_to_many :products, -> { select [ 'products.*', 'products_shops.*' ] }

end
