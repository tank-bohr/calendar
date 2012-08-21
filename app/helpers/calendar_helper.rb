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
end
