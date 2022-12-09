class Api::V1::Items::SearchController < ApplicationController
  def index
    if params[:name].present?
      if params[:min_price].present? || params[:max_price].present?
        render json: { data: 'Invalid Search' }, status: :bad_request
      else
        results = Item.name_search(params[:name])
        render json: ItemSerializer.new(results)
      end
    elsif params[:min_price].present? && params[:max_price].present?
      results = Item.range_search(params[:min_price], params[:max_price])
      if results.nil?
        render json: { data: {} }, status: :bad_request
      else
        render json: ItemSerializer.new(results)
      end
    elsif params[:min_price].present?
      if params[:min_price].to_f < 0
        render json: { errors: {} }, status: :bad_request
      else
        results = Item.min_search(params[:min_price])
        if results.nil?
          render json: { data: {} }, status: :bad_request
        else
          render json: ItemSerializer.new(results)
        end
      end
    elsif params[:max_price].present?
      if params[:max_price].to_f < 0
        render json: { errors: {} }, status: :bad_request
      else
        results = Item.max_search(params[:max_price])
        if results.nil?
          render json: { data: {} }, status: :bad_request
        else
          render json: ItemSerializer.new(results)
        end
      end
    else
      render json: { data: {} }, status: :bad_request
    end
  end
end