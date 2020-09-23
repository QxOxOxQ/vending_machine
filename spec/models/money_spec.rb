# frozen_string_literal: true

require_relative '../../app/models/money'

describe Money do
  describe '.add' do
    context 'when its first money with that worth' do
      it 'create money' do
        Money.add(2, 5)
        expect(Money.find_by(worth: 2).amount).to eq(5)
      end
    end

    context 'when money exists with that worth' do
      context 'with 0 amount' do
        let!(:money) { Money.create!(worth: 1, amount: 0) }

        it 'increase existed money' do
          Money.add(1, 1)
          expect(Money.find_by(worth: 1).amount).to eq(1)
        end
      end

      context 'with amount more than 0' do
        let!(:money) { Money.create!(worth: 1, amount: 10) }

        it 'increase existed money' do
          Money.add(1, 3)
          expect(Money.find_by(worth: 1).amount).to eq(13)
        end
      end
    end
  end
end
