class CalendarController < ApplicationController
  def by_week
    year = params[:year] || Date.today.year
    week = params[:week_number]
    @year, @week = year.to_i, week.to_i
    @list = Event.by_week(@year, @week)
  end

  def by_month
    year = params[:year] || Date.today.year
    month = params[:month]
    @year, @month = year.to_i, month.to_i
    @list = Event.by_month(@year, @month)
  end
end
