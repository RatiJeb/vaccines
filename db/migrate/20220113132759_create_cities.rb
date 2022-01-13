class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.references :country, null: false, foreign_key: true
      t.string :name, null: false, limit: 150
      t.string :code, null: false, limit: 50
      t.boolean :active, null: false, default: false
    end

    add_index :cities, [:country_id, :code], unique: true
  end
end
