class WeekDay < ActiveRecord::Base
  belongs_to :event
  attr_accessible :day
end
