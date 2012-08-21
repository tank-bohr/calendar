class AddPeriodToEvent < ActiveRecord::Migration
  def change
    add_column :events, :period, :integer
    add_column :events, :period_value, :string
  end
end
