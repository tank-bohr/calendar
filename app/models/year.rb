class Year < ActiveRecord::Base
  belongs_to :event
  attr_accessible :year

  def value
    year
  end
end
