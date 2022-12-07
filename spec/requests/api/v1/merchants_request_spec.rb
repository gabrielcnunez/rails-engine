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
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    create_list(:item, 2, merchant: merchant)
    create(:item, merchant: merchant2)

    get "/api/v1/merchants/#{merchant}/items"

    expect(response).to be_successful
  end
end