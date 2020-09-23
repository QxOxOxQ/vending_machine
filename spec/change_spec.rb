# frozen_string_literal: true

require_relative '../app/change'
describe Change do
  describe '.give' do
    let(:difference) { 389 }
    let(:change) { described_class.new(difference) }
    context 'when is enought money to give change' do
      before do
        Money.create!(worth: 200, amount: 2)
        # 189
        Money.create!(worth: 100, amount: 1)
        # 89
        Money.create!(worth: 50, amount: 2)
        # 39
        Money.create!(worth: 20, amount: 3)
        # 19
        Money.create!(worth: 2, amount: 20)
        # 1
        Money.create!(worth: 1, amount: 10)
        @result = change.give
      end
      it 'return hash change' do
        expect(@result).to eq({

                                200 => 1,
                                100 => 1,
                                50 => 1,
                                20 => 1,
                                2 => 9,
                                1 => 1
                              })
      end

      it('left_amount equal 0') { expect(change.left_amount).to eq 0 }

      it 'reduce money' do
        expect(Money.where(worth: [200, 100, 50, 20, 2, 1])
                   .order(worth: :desc)
                   .pluck(:amount)).to eq [1, 0, 1, 2, 11, 9]
      end
    end
    context 'when is not able to give full change' do
      before do
        Money.create!(worth: 200, amount: 5)
        @result = change.give
      end

      it('return hash change') { expect(@result).to eq({ 200 => 1 }) }
      it('left_amount equal 189') { expect(change.left_amount).to eq 189 }

      it 'not reduce money' do
        expect(Money.find_by(worth: 200).amount).to eq 5
      end
    end
    context 'when not have enough  change' do
      before do
        Money.create!(worth: 5, amount: 5)
        Money.create!(worth: 2, amount: 8)
        @result = change.give
      end

      it('return hash change') { expect(@result).to eq({ 5 => 5, 2 => 8 }) }
      it('left_amount equal 189') { expect(change.left_amount).to eq 348 }
      it 'not reduce money' do
        expect(Money.find_by(worth: 5).amount).to eq 5
        expect(Money.find_by(worth: 2).amount).to eq 8
      end
    end
  end
end
