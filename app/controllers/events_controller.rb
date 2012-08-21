class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create params[:event]
    @event.apply_period
  end

  def edit
     @event = Event.find params[:id]
  end

  def update
    @event = Event.find params[:id]
    @event.update_attributes(params[:event])
    @event.apply_period
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
  end
end