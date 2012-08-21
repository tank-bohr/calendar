class Event < ActiveRecord::Base
  attr_accessible :description, :time, :period, :period_value

  [:years, :months, :month_days, :week_days].each do |assoc|
    has_many assoc
    define_method("the_#{assoc.to_s}") do
        self.send(assoc).map{|item| item.value}
    end
  end

  PeriodMap = {once: 1, weekly: 2, monthly: 3}

  def period
    original_value = super()
    PeriodMap.invert[original_value]
  end

  def period= val
    value_to_set = PeriodMap[val]
    super(value_to_set)
  end

  def apply_period
    method = "add_#{period.to_s}".to_sym
    if @event.respond_to? method
      @event.send(method, period_value)
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


  def timef
    time.nil? ? '' : time.strftime('%l:%M %P')
  end

  def to_s
    "#{timef} -- #{description}"
  end


  def add_once str
    date = Date.parse(str)
    self.month_days = [ MonthDay.new(:day => date.day) ]
    self.months = [ Month.new(:month => date.month) ]
    self.years = [ Year.new(:year => date.year) ]
  end


  def add_weekly str
    days = str.split /\s*\,\s*/
    week_days_numbers = {mon: 1, tue: 2, wed: 3, thu: 4, fri: 5, sat: 6, sun: 7}

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
  end


  def add_monthly str
    days = str.split /\s*\,\s*/
    self.month_days = days.compact.uniq.map{|d| MonthDay.new :day => d.to_i}
  end
  
  
  class << self

    def all_events
      self.includes :years, :months, :month_days, :week_days
    end

    def events_of_range from, to
      retval = []
      events = all_events
      (from..to).each do |date|
        retval.push({
                  :date => date,
                  :events => events.select{ |ev| ev.belongs_to_date? date }
                })
      end

      return retval
    end


    def by_month year, month
      from = Date.new(year, month, 1)
      to = from.next_month - 1
      events_of_range from, to
    end
    
    def by_week year, week
      from = Date.commercial(year, week, 1)
      to = Date.commercial(year, week, 7)
      events_of_range(from, to)
    end
  end
end
