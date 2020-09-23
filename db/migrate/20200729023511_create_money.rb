class CreateMoney < ActiveRecord::Migration[6.0]
  def change
    create_table :money do |t|
      t.integer :worth, null: false
      t.integer :amount, null: false, default: 0
    end

    add_index :money, :worth, unique: true
  end
end
