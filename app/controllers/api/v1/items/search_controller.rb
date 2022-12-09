class Api::V1::Items::SearchController < ApplicationController
  def index
    if params.include?(:name)
      results = Item.name_search(params[:name])
      render json: ItemSerializer.new(results)
    elsif params.include?("min_price" && "max_price")
      results = Item.range_search(params[:min_price], params[:max_price])
      render json: ItemSerializer.new(results)
    elsif params.include?(:min_price)
      results = Item.min_search(params[:min_price])
      render json: ItemSerializer.new(results)
    elsif params.include?(:max_price)
      results = Item.max_search(params[:max_price])
      render json: ItemSerializer.new(results)
    end
  end
end