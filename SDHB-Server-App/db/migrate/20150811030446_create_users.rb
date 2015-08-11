class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :staffID
      t.string :lastName
      t.string :firstName
      t.string :deviceID
      t.boolean :authenticated
      t.string :region
      t.integer :group

      t.timestamps
    end
  end
end
