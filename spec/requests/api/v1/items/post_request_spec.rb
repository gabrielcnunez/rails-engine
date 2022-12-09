require 'rails_helper'

describe 'Items API POST request' do
  it 'can create a new item' do
    id = create(:merchant).id
    item_params = ({
                    name: 'Widget',
                    description: 'High quality widget',
                    unit_price: 109.99,
                    merchant_id: id
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end
end