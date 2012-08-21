class CalendarController < ApplicationController

  def by_day
    year  = params[:year] || Date.today.year
    month = params[:month]
    day   = params[:day]
    @year, @month, @day = year.to_i, month.to_i, day.to_i
    date = Date.new(@year, @month, @day);
    list = Event.events_of_range(date, date)
    @item = list.first
  end

  def by_week
    year = params[:year] || Date.today.year
    week = params[:week]
    @year, @week = year.to_i, week.to_i
    @list = Event.by_week(@year, @week)
  end

  def by_month
    year  = params[:year] || Date.today.year
    month = params[:month]
    @year, @month = year.to_i, month.to_i
    @list = Event.by_month(@year, @month)
  end
end
