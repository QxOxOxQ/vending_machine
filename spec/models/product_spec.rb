require_relative '../../app/models/product'

describe Product do
  let!(:product) { Product.create(name: 'test', price: 1, amount: 1) }
  describe '#increase_amount' do
    it 'increase amount by 1' do
      product.increase_amount
      expect(product.reload.amount).to eq(2)
    end
  end
  describe '#decrease_amount' do
    it 'decrease amount by 1' do
      product.decrease_amount
      expect(product.reload.amount).to eq(0)
    end
  end
  describe '#available?' do
    it 'when amount is more than 0 return true' do
      expect(product.available?).to eq(true)
    end
    it 'when amount is 0 return false' do
      product.update!(amount: 0)
      expect(product.reload.available?).to eq(false)
    end
  end
end
