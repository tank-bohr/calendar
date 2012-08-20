class MonthDay < ActiveRecord::Base
  belongs_to :event
  attr_accessible :day
end
