class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.string :name, null: false, limit: 150
      t.string :code, null: false, limit: 50
      t.boolean :active, null: false, default: false
    end
    
    add_index :countries, :code, unique: true
  end
end
