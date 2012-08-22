require 'spec_helper'

describe Event do
  before do
    @event = Event.new(:time => Time.now, :description => 'text')
    @event.week_days = [
      WeekDay.new(:day => 1),
      WeekDay.new(:day => 3),
      WeekDay.new(:day => 5)
    ]
    @event.save
  end

  subject { @event }

  it { should be_valid }


  describe "Event model associations" do
    [:years, :months, :month_days, :week_days].each do |assoc|
      it { should respond_to(assoc)}
      it { should respond_to("the_#{assoc}".to_sym)}
    end

    it "should return list of week days numbers" do
      @event.the_week_days.should eq([1, 3, 5])
    end

    it "should return list of month days" do
        @event.month_days = [
          MonthDay.new(:day => 11),
          MonthDay.new(:day => 13)
        ]
        @event.month_days.each { |md| md.should be_kind_of(MonthDay) }
        @event.the_month_days.should eq([11, 13])
    end
  end

  describe "belongs_to_date? method" do
    before do
      @date = Date.today
      @event = Event.new
    end

    it "belongs to any date" do
      @event.belongs_to_date?(@date).should be_true
    end

    it "does not" do
      @event.month_days = [MonthDay.new(:day => @date.next_day.day)]
      @event.belongs_to_date?(@date).should be_false
    end

    it "neither" do
      @event.month_days = [MonthDay.new(:day => @date.next_day.day)]
      @event.week_days = [WeekDay.new(:day => @date.wday)]
      @event.belongs_to_date?(@date).should be_false
    end

    it "belongs" do
      @event.week_days = [WeekDay.new(:day => @date.wday)]
      @event.belongs_to_date?(@date).should be_true
    end
  end

  describe "add periodic to event" do
    before do
      @event = Event.new
    end

    it "should add weekly period to event" do
      @event.add_weekly 'mon, Wed, 5'
      @event.the_week_days.should eq([1, 3, 5])
    end

    it "should add monthly period to event" do
      @event.add_monthly '5, 20'
      @event.the_month_days.should eq([5, 20])
    end
  end

  describe "methods for calendar presentation" do
    before do
      Event.find_each{ |event| event.destroy }
      @event = Event.create
      @from = Date.today.prev_day
      @to = Date.today.next_day
    end

    it "should return 3 days list without events" do
      @event.month_days = [MonthDay.new(:day => (Date.today + 2).day)]
      list = Event.events_of_range @from, @to
      list.count.should be 3
      list.each do |item|
        item[:events].should_not be_nil
        item[:events].should be_empty
      end
    end

    it "should return 3 days list without events" do
      @event.month_days = [MonthDay.new(:day => (Date.today + 2).day)]
      list = Event.events_of_range @from, @to
      list.count.should be 3
      list.each do |item|
        item[:events].should_not be_nil
        item[:events].should be_empty
      end
    end

    it "should return 1 day list with today event" do
      desc = 'Today event'
      today = Date.today
      @event.description = desc
      @event.month_days = [ MonthDay.new(:day => today.day) ]
      @event.save
      
      list = Event.events_of_range(today, today)
      list.count.should be 1
      list.first[:events].count.should be 1
      list.first[:events].first.description.should eq(desc)
    end
  end
end
