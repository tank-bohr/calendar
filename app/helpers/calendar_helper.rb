module CalendarHelper
  def next_week_url
    date = Date.commercial(@year, @week).next_week
    next_week = date.cweek
    next_week_year = date.year
    "/calendar/week/#{next_week}/#{next_week_year}"
  end

  def prev_week_url
    date = Date.commercial(@year, @week).prev_week
    next_week = date.cweek
    next_week_year = date.year
    "/calendar/week/#{next_week}/#{next_week_year}"
  end

  def next_month_url
    date = Date.new(@year, @month, 1).next_month
    next_month = date.month
    next_month_year = date.year
    "/calendar/month/#{next_month}/#{next_month_year}"
  end

  def prev_month_url
    date = Date.new(@year, @month, 1).prev_month
    prev_month = date.month
    prev_month_year = date.year
    "/calendar/month/#{prev_month}/#{prev_month_year}"
  end

  def next_day_url
    date = Date.new(@year, @month, @day).next_day
    next_day = date.day
    next_day_month = date.month
    next_day_year = date.year
    "/calendar/day/#{next_day}/#{next_day_month}/#{next_day_year}"
  end

  def prev_day_url
    date = Date.new(@year, @month, @day).prev_day
    prev_day = date.day
    prev_day_month = date.month
    prev_day_year = date.year
    "/calendar/day/#{prev_day}/#{prev_day_month}/#{prev_day_year}"
  end
end
