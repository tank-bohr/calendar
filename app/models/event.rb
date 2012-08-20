class Event < ActiveRecord::Base
  attr_accessible :description, :time

  [:years, :months, :month_days, :week_days].each do |assoc|
    has_many assoc
    define_method("the_#{assoc.to_s}") do
        self.send(assoc).map{|item| item.value}
    end
  end

  def belongs_to_date? date
    unless years.empty? || the_years.include?(date.year)
        return false
    end

    unless months.empty? || the_months.include?(date.month)
        return false
    end

    unless month_days.empty? || the_month_days.include?(date.day)
        return false
    end

    unless week_days.empty? || the_week_days.include?(date.wday)
        return false
    end

    true
  end


  def add_weekly str
  end

  def add_monthly str
    days = str.split /\s*\,\s*/
    self.month_days = days.map{|d| MonthDay.new :day => d}
    self.save
  end
end
