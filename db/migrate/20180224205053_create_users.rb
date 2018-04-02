class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email
      t.string :password_digest
      # t.string :provider
      # t.string :uid
      # t.string :name
      t.timestamps
    end
  end
end
