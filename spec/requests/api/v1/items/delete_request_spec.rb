require 'rails_helper'

describe 'Items API' do
  it 'can destroy an item along with any invoice where it was the only item' do
    item1 = create(:item)
    
    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item1.id}"

    expect(response).to have_http_status(204)
    expect(Item.count).to eq(0)
    expect{Item.find(item1.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end