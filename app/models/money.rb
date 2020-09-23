# frozen_string_literal: true

require 'active_record'
class Money < ActiveRecord::Base
  ACCEPTABLE_WORTH = [1, 2, 5, 10, 20, 50, 100, 200].freeze

  validates :worth, presence: true, uniqueness: { case_insensitive: true }
  validates :amount, presence: true
  validates :amount, :worth, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :worth_must_be_acceptable

  scope :available, -> { where('amount > ?', 0).order(worth: :desc) }

  def self.add(worth, amount)
    money = find_by(worth: worth)
    if money
      money.update(amount: money.amount + amount)
    else
      create(worth: worth, amount: amount)
    end
  end

  def worth_must_be_acceptable
    errors.add(:worth, 'unacceptable value') unless ACCEPTABLE_WORTH.include?(worth)
  end

  def reduce!(count)
    update!(amount: amount - count)
  end
end
