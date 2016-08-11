class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, :null => false, :default => ''
      t.string :password, :null => false, :default => ''
      t.integer :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.integer :failed_attempts, :default => 0
      t.boolean :is_admin, :default => false
      t.timestamps
    end
  end
end
