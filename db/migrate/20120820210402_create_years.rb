class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
      t.references :event
      t.integer :year

      t.timestamps
    end
    add_index :years, :event_id
  end
end
