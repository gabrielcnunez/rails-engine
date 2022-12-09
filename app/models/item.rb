class Item < ApplicationRecord
  belongs_to :merchant

  def self.name_search(param)
    where('name ILIKE ?', "%#{param}%").order(:name).first
  end
  
  def self.min_search(param)
    where('unit_price > ?', param).order(:name).first
  end
end