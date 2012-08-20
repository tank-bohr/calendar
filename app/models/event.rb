class Event < ActiveRecord::Base
  attr_accessible :description, :time

  has_many :years
  has_many :months
  has_many :month_days
  has_many :week_days

  def belongs_to_date? date
    if !years.empty? && years.detect{|y| y.year == date.year}.nil?
        return false
    end

    if !months.empty? && months.detect{|m| m.month == date.month}.nil?
        return false
    end

    if !month_days.empty? && month_days.detect{|md| md.day == date.day}.nil?
        return false
    end

    if !week_days.empty? && week_days.detect{|wd| wd.day == date.wday}.nil?
        return false
    end

    true
  end
end
