class AddUserToTimezone < ActiveRecord::Migration[5.0]
  def change
    add_column :timezones, :user_id, :integer
    add_index :timezones, :user_id
  end
end
