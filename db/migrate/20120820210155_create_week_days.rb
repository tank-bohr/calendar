class CreateWeekDays < ActiveRecord::Migration
  def change
    create_table :week_days do |t|
      t.references :event
      t.integer :day

      t.timestamps
    end
    add_index :week_days, :event_id
    add_index :week_days, [:event_id, :day], :unique => true
  end
end
