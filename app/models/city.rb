class City < ApplicationRecord
  belongs_to :country
  has_many :districts

  scope :by_country, -> (country_id) {where(country_id: country_id)}
  scope :active, -> {where(active: true)}
  
  validates :country_id, :name, :code, presence: true
end
