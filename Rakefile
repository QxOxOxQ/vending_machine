# frozen_string_literal: true

require 'standalone_migrations'
require_relative 'app/main'
StandaloneMigrations::Tasks.load_tasks

task :add_product, [:name, :price, :amount] do |_t, args|
  p Product.create!(name: args[:name], price: args[:price].to_i, amount: args[:amount].to_i)
end

task :update_product, [:name, :price, :amount] do |_t, args|
  p Product.find_by(name: args[:name]).update!(price: args[:price].to_i, amount: args[:amount].to_i)
end
task :add_money, [:worth, :amount] do |_t, args|
  p Money.create!(worth: args[:worth], amount: args[:amount].to_i)
end

task :update_money, [:worth, :amount] do |_t, args|
  p Money.find_by(worth: args[:worth]).update!(amount: args[:amount].to_i)
end

task :buy, [:name, :money] do |_t, args|
  if (product = Product.find_by(name: args[:name]))
    money = args[:money].split(' ').map(&:to_i)
    p Transaction.new(product, *money).buy
  else
    p "#{args[:name]} is not here"
  end
end

task :product_list do
  Product.all.each { |product| p product }
end
task :money_list do
  Money.all.each { |money| p money }
end
