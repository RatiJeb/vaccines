class AddDescriptionToVaccineItems < ActiveRecord::Migration[6.1]
  def change
    add_column :vaccine_items, :description, :string
  end
end
