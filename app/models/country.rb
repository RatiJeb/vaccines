class Country < ApplicationRecord
  has_many :cities
  validates :name, :code, presence: true
end
