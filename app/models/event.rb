class Event < ActiveRecord::Base
  attr_accessible :description, :time

  [:years, :months, :month_days, :week_days].each do |assoc|
    has_many assoc
    define_method("the_#{assoc.to_s}") do
        self.send(assoc).map{|item| item.value}
    end
  end

  def belongs_to_date? date
    unless years.empty?      || the_years.include?(date.year)
        return false
    end

    unless months.empty?     || the_months.include?(date.month)
        return false
    end

    unless month_days.empty? || the_month_days.include?(date.day)
        return false
    end

    unless week_days.empty?  || the_week_days.include?(date.wday)
        return false
    end

    true
  end


  def add_weekly str
    days = str.split /\s*\,\s*/
    week_days_numbers = {mon: 1, tue: 2, wed: 3, thu: 4, fri: 5, sat: 6, sun: 7}
    p week_days_numbers

    processed = days.map do |d|
        digit = nil
        if d =~ /^\d$/
            digit = d.to_i
        elsif d =~ /(\w+)/
            word = $1
            digit = week_days_numbers[word.downcase.to_sym]
        end
        digit
    end.compact.uniq

    self.week_days = processed.map{|day| WeekDay.new :day => day}

    self.save
  end

  def add_monthly str
    days = str.split /\s*\,\s*/
    self.month_days = days.map{|d| MonthDay.new :day => d}.uniq
    self.save
  end
end
