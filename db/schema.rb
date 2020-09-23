# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_729_023_511) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'money', force: :cascade do |t|
    t.integer 'worth', null: false
    t.integer 'amount', default: 0, null: false
    t.index ['worth'], name: 'index_money_on_worth', unique: true
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name', null: false
    t.integer 'price', null: false
    t.integer 'amount', default: 0, null: false
    t.index ['name'], name: 'index_products_on_name', unique: true
  end
end
