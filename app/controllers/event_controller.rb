class EventController < ApplicationController
  include EventHelper

  def create
    time = extract_time()
    @event = Event.create(:description => params[:description], :time => time)

    if 'once' == params[:period]
       @event.add_once params[:period_values]
    elsif 'weekly' == params[:period]
      @event.add_weekly params[:period_values]
    elsif 'monthly' == params[:period]
      @event.add_montly params[:period_values]
    end
  end
end
