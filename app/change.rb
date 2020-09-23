# frozen_string_literal: true

require_relative 'models/money'

class Change
  attr_reader :hash_change, :left_amount

  def initialize(difference)
    @difference = difference
    @hash_change = {}
    @left_amount = 0
  end

  def give
    return @hash_change if @difference.zero?

    left_difference = @difference
    Money.available.each do |money|
      expected_amount = left_difference / money.worth
      next if expected_amount.zero?

      left_difference -= give_that_money(money, expected_amount, left_difference)
    end
    @left_amount = left_difference
    process_hash
    @hash_change
  end

  def left?
    @left_amount.positive?
  end

  private

  def process_hash
    @hash_change.clone.each do |money, amount|
      reduce_money(money, amount) unless left?
      change_keys(money)
    end
  end

  def change_keys(money)
    @hash_change[money.worth] = @hash_change.delete money
  end

  def reduce_money(money, amount)
    money.reduce!(amount)
  end

  def give_that_money(money, expected_amount, _left_difference)
    amount = if money.amount >= expected_amount
               expected_amount
             else
               money.amount
             end
    @hash_change[money] = amount
    amount * money.worth
  end
end
