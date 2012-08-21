class EventController < ApplicationController
  include EventHelper

  def create
    time = extract_time()
    @event = Event.create(:description => params[:description], :time => time)

    method = "add_#{params[:period]}".to_sym
    if @event.respond_to? method
      @event.send(method, params[:period_values])
    end
  end
end
