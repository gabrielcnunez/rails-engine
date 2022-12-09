require 'rails_helper'

describe 'Items API PATCH request' do
  it 'can update an item' do
    id = create(:item).id
    old_name = Item.last.name
    item_params = { name: 'Something New'}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(old_name)
    expect(item.name).to eq('Something New')
  end
end