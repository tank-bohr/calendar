class CreateMonths < ActiveRecord::Migration
  def change
    create_table :months do |t|
      t.references :event
      t.integer :month

      t.timestamps
    end
    add_index :months, :event_id
  end
end
