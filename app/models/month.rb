class Month < ActiveRecord::Base
  belongs_to :event
  attr_accessible :month
end
