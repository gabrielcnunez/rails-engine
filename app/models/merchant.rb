class Merchant < ApplicationRecord
  has_many :items

  def self.merchant_search(param)
    where('name ILIKE ?', "%#{param}%").order(:name)
  end
end