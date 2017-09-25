class CreateProductsShops < ActiveRecord::Migration[5.1]
  def up
    create_join_table :products, :shops
    add_column :products_shops, :price, :decimal
    add_column :products_shops, :quantity, :decimal
  end

  def down
    drop_table :products_shops
  end
end
