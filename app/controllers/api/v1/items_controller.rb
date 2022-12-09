class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    new_item = ItemSerializer.new(Item.create(item_params))
    render json: new_item, status: :created
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def destroy
    Item.find(params[:id]).destroy!

    head :no_content
  end

  def merchant_items
    merchant = Merchant.find(params[:merchant_id])
    render json: ItemSerializer.new(merchant.items)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end