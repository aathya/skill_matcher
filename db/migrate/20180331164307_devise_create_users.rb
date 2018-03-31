class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.datetime :remember_created_at
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip
      t.timestamps null: false

      #other columns
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :profile_type, default: 'customer', null: false
    end

    add_index :users, :email,                unique: true
  end
end
