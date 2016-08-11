class CreateTimezones < ActiveRecord::Migration[5.0]
  def change
    create_table :timezones do |t|
      t.string :name
      t.string :city
      t.integer :gmt_offset
      t.timestamps
    end
  end
end
