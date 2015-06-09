class CreateEmergencyNotifications < ActiveRecord::Migration
  def change
    create_table :emergency_notifications do |t|
      t.string :title
      t.string :message

      t.timestamps
    end
  end
end
