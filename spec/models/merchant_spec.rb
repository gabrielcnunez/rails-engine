require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'methods' do
    describe '#merchant_search' do
      it 'returns all merchants using case insensitive partial match query params' do
        merchant1 = create(:merchant, name: "BoJack Horseman")
        merchant2 = create(:merchant, name: "Jack Shepard")
        merchant3 = create(:merchant, name: "Audrey Horne")

        expect(Merchant.merchant_search('jack')).to eq([merchant1, merchant2])
      end
    end
  end
end