require 'rails_helper'

describe 'Items API GET request' do
  it 'sends a list of items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)

    items = response_body[:data]

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it 'can get one item by its id' do
    id = create(:item).id.to_s

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
  
    item = response_body[:data]

    expect(item).to have_key(:id)
    expect(item[:id]).to eq(id)
  
    expect(item).to have_key(:attributes)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)
  end

  it 'can get the merchant for an item' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item = create(:item, merchant: merchant1)
    id = item.id

    get "/api/v1/items/#{id}/merchant"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)

    items_merchant = response_body[:data]

    expect(items_merchant[:attributes][:name]).to eq(merchant1.name)
  end

  describe 'query params search' do
    before :each do
      @item1 = create(:item, name: 'India Pale Beer', unit_price: 12.99)
      @item2 = create(:item, name: 'Christmas Ale', unit_price: 8.99)
      @item3 = create(:item, name: 'Boston Lager', unit_price: 9.99)
      @item4 = create(:item, name: 'Amber Bock', unit_price: 4.99)
    end
    
    it 'can find an item based on name query params' do
      get '/api/v1/items/find?name=ale'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)

      item_by_name = response_body[:data]

      expect(item_by_name[:attributes][:name]).to eq(@item2.name)
    end
    
    it 'can find an item based on mininum price query params' do
      get '/api/v1/items/find?min_price=5'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)

      item_by_min_price = response_body[:data]

      expect(item_by_min_price[:attributes][:name]).to eq(@item3.name)
    end
    
    it 'can find an item based on maximum price query params' do
      get '/api/v1/items/find?max_price=9'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)

      item_by_max_price = response_body[:data]

      expect(item_by_max_price[:attributes][:name]).to eq(@item4.name)
    end
    
    it 'can find an item based on minimum and maximum price query params' do
      get '/api/v1/items/find?min_price=10&max_price=15'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)

      item_by_min_and_max_price = response_body[:data]

      expect(item_by_min_and_max_price[:attributes][:name]).to eq(@item1.name)
    end

    describe "returns 'invalid search' and a 400 status" do
      it 'when name and min_price query parameters are sent' do
        get '/api/v1/items/find?min_price=5&name=ale'

        error = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)
        expect(error[:data]).to eq('Invalid Search')
      end

      it 'when name and max_price query parameters are sent' do
        get '/api/v1/items/find?max_price=10&name=ale'

        error = JSON.parse(response.body, symbolize_names: true)
  
        expect(response).to have_http_status(400)
        expect(error[:data]).to eq('Invalid Search')
      end
    end

    describe "returns an empty error hash and a 400 status" do
      it 'when min_price is a negative number' do
        get '/api/v1/items/find?min_price=-10'

        error = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)
        expect(error[:errors]).to eq({})
      end
      
      it 'when max_price is a negative number' do
        get '/api/v1/items/find?max_price=-10'

        error = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)
        expect(error[:errors]).to eq({})
      end
    end

    describe "returns an empty data hash and a 400 status" do
      it 'when min_price does not have a match' do
        get '/api/v1/items/find?min_price=500'

        no_results = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)
        expect(no_results[:data]).to eq({})
      end
      
      it 'when max_price does not have a match' do
        get '/api/v1/items/find?max_price=1'

        no_results = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)
        expect(no_results[:data]).to eq({})
      end
    end
  end
end