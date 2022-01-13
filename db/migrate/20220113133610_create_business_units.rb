class CreateBusinessUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :business_units do |t|
      t.references :country, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.references :district, null: false, foreign_key: true
      t.string :name, null: false, limit: 150
      t.string :code, null: false, limit: 50
      t.boolean :active, null: false, default: false

      t.timestamps
    end

    add_index :business_units, [:country_id, :city_id, :code], unique: true
  end
end
