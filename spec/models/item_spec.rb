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
    @item5 = create(:item, name: 'Winter Ale', unit_price: 13.99)
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
  
  describe '#max_search' do
    it 'returns an item below a maximum price query param' do
      expect(Item.max_search(9)).to eq(@item4)
    end
  end

  describe '#range_search' do
    it 'returns an item with a range of minimum and maximum price query param' do
      expect(Item.range_search(10, 15)).to eq(@item1)
    end
  end
end
