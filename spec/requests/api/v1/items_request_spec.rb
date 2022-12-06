require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)

      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)
      
      expect(item).to have_key(:description)
      expect(item[:name]).to be_a(String)

      expect(item).to have_key(:unit_price)
      expect(item[:name]).to be_a(Float)

      expect(item).to have_key(:merchant_id)
      expect(item[:name]).to be_a(Integer)
    end
  end
end