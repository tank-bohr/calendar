class Month < ActiveRecord::Base
  belongs_to :event
  attr_accessible :month

  def value
  	month
  end
end
