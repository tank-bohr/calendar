class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
      t.references :event
      t.integer :year

      t.timestamps
    end
    add_index :years, :event_id
    add_index :years, [:event_id, :year], :unique => true
  end
end
