require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant }
end

describe 'methods' do
  before :each do
    @item1 = create(:item, name: 'India Pale Beer', unit_price: 12.99)
    @item2 = create(:item, name: 'Christmas Ale', unit_price: 8.99)
    @item3 = create(:item, name: 'Boston Lager', unit_price: 9.99)
    @item4 = create(:item, name: 'Amber Bock', unit_price: 4.99)
  end

  describe '#name_search' do
    it 'returns an item using case insensitive partial match name param' do
      expect(Item.name_search('ale')).to eq(@item2)
    end
  end

  describe '#min_search' do
    it 'returns an item above a minimum price query param' do
      expect(Item.min_search(5)).to eq(@item3)
    end
  end
end
