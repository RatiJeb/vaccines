class CreateDistricts < ActiveRecord::Migration[6.1]
  def change
    create_table :districts do |t|
      t.references :city, null: false, foreign_key: true
      t.string :name, null: false, limit: 150
      t.string :code, null: false, limit: 50
      t.boolean :active, null: false, default: false
    end
    add_index :districts, [:city_id, :code], unique: true
  end
end
