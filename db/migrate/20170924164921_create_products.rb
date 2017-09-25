class CreateProducts < ActiveRecord::Migration[5.1]
  def up
    create_table :products do |t|
      t.timestamps
      t.string :name
      t.text :description
    end
  end

  def down
    drop_table :products
  end

end
