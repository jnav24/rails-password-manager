class CreatePasswords < ActiveRecord::Migration[7.1]
  def change
    create_table :passwords do |t|
      t.string :url
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
