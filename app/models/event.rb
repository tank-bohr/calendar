class Event < ActiveRecord::Base
  attr_accessible :description, :time

  has_many :years
  has_many :months
  has_many :month_days
  has_many :week_days
end
