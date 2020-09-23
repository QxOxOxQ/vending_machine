# frozen_string_literal: true

require 'active_record'

class Product < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_insensitive: true }
  validates :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def available?
    amount > 0
  end

  def decrease_amount
    update(amount: amount - 1)
  end

  def increase_amount
    update(amount: amount + 1)
  end
end
