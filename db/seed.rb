# frozen_string_literal: true

require_relative '../app/main'

Product.create(name: 'cola', price: 120, amount: 10)
Product.create(name: 'sprite', price: 200, amount: 0)
Product.create(name: 'red bull', price: 320, amount: 0)
Product.create(name: 'kaszanka', price: 999, amount: 0)

Money::ACCEPTABLE_WORTH.each do |worth|
  Money.create(worth: worth, amount: rand(100))
end
