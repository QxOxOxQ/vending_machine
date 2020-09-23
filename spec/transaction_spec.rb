# frozen_string_literal: true

require_relative '../app/transaction'
describe Transaction do
  describe '.buy' do
    let(:product) { Product.create(name: 'cola', price: 120, amount: 10) }
    context 'when money are invalid' do
      context 'when money are strings' do
        let(:transaction) { described_class.new(product, 2, 'a') }
        before { @result = transaction.buy }
        it('product is not taken') { expect(product.reload.amount).to eq 10 }
        it('return error') { expect(@result).to eq(money: '["a"] are not valid') }
      end

      context 'when money are unacceptable values' do
        let(:transaction) { described_class.new(product, 18, 2, 3) }
        before { @result = transaction.buy }
        it('product is not taken') { expect(product.reload.amount).to eq 10 }
        it('return error') { expect(@result).to eq(money: '[18, 3] are not valid') }
      end
    end

    context 'when produts amount is 0' do
      let(:unavailable_product) { Product.create(name: 'sprite', price: 120, amount: 0) }
      it 'when money are unacceptable values return errors' do
        transaction = described_class.new(unavailable_product, 5)
        expect(transaction.buy).to eq(product: 'sprite is not available')
      end
    end

    context 'when is not enough money' do
      before { @result = described_class.new(product, 5).buy }
      it('product is not taken') { expect(product.reload.amount).to eq 10 }
      it('return error') { expect(@result).to eq(money: 'those are not enough money, add 115') }
    end

    context 'when is enough money' do
      context 'when money that were pass are enough for change' do
        before { @result = described_class.new(product, 100, 50, 20, 10).buy }
        it('product is taken') { expect(product.reload.amount).to eq 9 }
        it('give a change') { expect(@result).to eq(product: 'cola', change: { 50 => 1, 10 => 1 }) }
      end
    end

    context 'when there are money enough for change' do
      before do
        Money.create(worth: 1, amount: 200)
        Money.create(worth: 50, amount: 200)
        @result = described_class.new(product, 200).buy
      end
      it('product is taken') { expect(product.reload.amount).to eq 9 }
      it('give a change') { expect(@result).to eq(product: 'cola', change: { 50 => 1, 1 => 30 }) }
    end

    context 'when there are not enough money for change' do
      let!(:money) { Money.create(worth: 1, amount: 1) }
      before { @result = described_class.new(product, 200).buy }

      it('product is not taken') { expect(product.reload.amount).to eq 10 }
      it('money is not change') { expect(money.reload.amount).to eq 1 }
      it('money is not added') { expect(Money.count).to eq 1 }
      it('return error') { expect(@result).to eq(change: 'It is not enough money give change') }
    end
  end
end
