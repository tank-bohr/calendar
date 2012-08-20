class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :description
      t.time :time

      t.timestamps
    end
  end
end
