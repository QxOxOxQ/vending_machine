# frozen_string_literal: true

require_relative 'models/product'
require_relative 'models/money'
require_relative 'change'
class Transaction
  def initialize(product, *money)
    @product = product
    @money = money
    @errors = {}
  end

  def buy
    return @errors unless valid?

    if enough_money?
      handle_process
    else
      @errors[:money] = "those are not enough money, add #{worth_difference.abs}"
      @errors
    end
  end

  private

  def enough_money?
    worth_difference >= 0
  end

  def handle_process
    ActiveRecord::Base.transaction do
      take_money
      @change = give_change(worth_difference)
      @product.decrease_amount unless errors?
      raise ActiveRecord::Rollback if errors?
    end
    if errors?
      @errors
    else
      { product: @product.name, change: @change.hash_change }
    end
  end

  def errors?
    @errors.present?
  end

  def give_change(worth_difference)
    change = Change.new(worth_difference)
    change.give
    @errors[:change] = 'It is not enough money give change' if change.left?
    change
  end

  def take_money
    hash_money.each { |worth, amount| Money.add(worth, amount) }
  end

  def hash_money
    return @hash_money if @hash_money

    @hash_money = {}
    @money.each do |money|
      if @hash_money.key?(money)
        @hash_money[money] += 1
      else
        @hash_money[money] = 1
      end
    end
    @hash_money
  end

  def valid?
    unvalid_money = @money.reject do |money|
      money.is_a?(Integer) && Money::ACCEPTABLE_WORTH.include?(money)
    end
    @errors[:money] = "#{unvalid_money} are not valid" if unvalid_money.present?
    @errors[:product] = "#{@product.name} is not available" unless @product.available?
    @errors.empty?
  end

  def worth_difference
    @worth_difference ||= @money.sum - @product.price
  end
end
