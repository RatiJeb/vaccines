class District < ApplicationRecord
  belongs_to :city
  scope :by_city, -> (city_id) {where(city_id: city_id)}
  validates :city_id, :name, :code, presence: true
end
