class AddRoleToUserPasswords < ActiveRecord::Migration[7.1]
  def change
    add_column :user_passwords, :role, :string
  end
end
