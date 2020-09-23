class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :amount, null: false, default: 0
    end

    add_index :products, :name, unique: true
  end
end
