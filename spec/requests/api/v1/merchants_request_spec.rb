require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)

    merchants = response_body[:data]

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'can get one merchant by its id' do
    id = create(:merchant).id.to_s

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
  
    merchant = response_body[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(id)
  
    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes][:name]).to be_a(String)
  end

  it "can get all of a merchant's items by its id" do
    merchant1 = create(:merchant)
    id = merchant1.id
    merchant2 = create(:merchant)
    create_list(:item, 2, merchant: merchant1)
    create(:item, merchant: merchant2)

    get "/api/v1/merchants/#{id}/items"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)

    merchant_items = response_body[:data]

    expect(merchant_items.count).to eq(2)

    merchant_items.each do |item|
      expect(item[:attributes][:merchant_id]).to eq(id)
    end
  end

  it 'can find all merchants using case insensitive, partial match query params' do
    merchant1 = create(:merchant, name: "BoJack Horseman")
    merchant2 = create(:merchant, name: "Jack Shepard")
    merchant3 = create(:merchant, name: "Audrey Horne")

    get "/api/v1/merchants/find_all?name=jack"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)

    found_merchants = response_body[:data]

    expect(found_merchants.count).to eq(2)
  end
end