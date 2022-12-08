class Api::V1::Merchants::SearchController < ApplicationController
  def index
    # if params.include?(:name)
      results = Merchant.merchant_search(params[:name])
      render json: MerchantSerializer.new(results)
    # else
  end
end