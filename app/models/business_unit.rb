class BusinessUnit < ApplicationRecord
  belongs_to :country
  belongs_to :city
  belongs_to :district

  validates :country_id, :city_id, :district_id, :name, :code, presence: true
end
