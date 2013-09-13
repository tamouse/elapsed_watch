require 'spec_helper'

describe ElapsedWatch do

  context "file handling" do
    context "should use the default file" do
      before(:each) do
        File.should_receive(:read).with(ElapsedWatch::DEFAULT_EVENT_FILE).and_return("Event: 2013-09-01")
      end
      let(:events) {ElapsedWatch::EventCollection.new()}
      it{events.should_not be_nil}
      it{events.size.should be 1}
      it{events.first.instance_variable_get("@event_name").should eq "Event"}
      it{events.first.instance_variable_get("@event_time").should eq Time.new(2013,9,1)}
    end
    context "should use the given file" do
      before(:each) do
        File.should_receive(:read).with("events").and_return("Alt Event: 2013-09-01")
      end
      let(:events) { ElapsedWatch::EventCollection.new("events") }
      it {events.should_not be_nil}
      it {events.size.should eq 1}
      it {events.first.instance_variable_get("@event_name").should eq "Alt Event"}
    end

  end

  context "processing events" do
    before(:each) do
      File.stub(:read).and_return("Past Event: 2013-01-25\nFuture Event: 2015-04-15")
    end

    let(:events) {ElapsedWatch::EventCollection.new()}
    let(:output) do
      Timecop.freeze(Time.new(2013,6,1)) do
        events.map(&:to_s)      
      end
    end
    
    it {events.size.should eq 2}

    it {events.first.should be_an ElapsedWatch::Event}
    it {events.first.instance_variable_get("@event_name").should eq "Past Event"}
    it {events.first.instance_variable_get("@event_time").should eq Time.new(2013,1,25)}

    it {events.last.should be_an ElapsedWatch::Event}
    it {events.last.instance_variable_get("@event_name").should eq "Future Event"}
    it {events.last.instance_variable_get("@event_time").should eq Time.new(2015,4,15)}

    it {output.size.should eq 2}
    it "should have correct output" do
      output.should eq ["Past Event 4 mos 6 days 23 hrs ago", "Future Event in 1 yr 10 mos 18 days"]
    end
    
  end

  context "reloading events" do
    it "should reload events when a file name is assigned" do
      File.stub(:read => "Event: 2001-01-01")
      events = ElapsedWatch::EventCollection.new()
      events.clear
      events.size.should be_zero
      events.event_file="dummy"
      events.size.should eq 1
      events.first.instance_variable_get("@event_name").should eq "Event"
      events.first.instance_variable_get("@event_time").should eq Time.new 2001, 1, 1
    end

  end


end

