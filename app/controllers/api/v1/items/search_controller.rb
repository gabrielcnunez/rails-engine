class Api::V1::Items::SearchController < ApplicationController
  def index
    # require 'pry'; binding.pry
    results = Item.name_search(params[:name])
    render json: ItemSerializer.new(results)
  end
end