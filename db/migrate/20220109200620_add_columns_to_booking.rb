class AddColumnsToBooking < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :ip_address, :string, limit: 50
    add_column :bookings, :browser_name, :string, limit: 50
    add_column :bookings, :os_name, :string, limit: 50
  end
end
