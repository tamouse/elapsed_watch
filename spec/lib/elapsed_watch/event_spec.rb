require 'spec_helper'

describe ElapsedWatch do
  let(:event1) {ElapsedWatch::Event.new("First of September: 2013-09-01")}
  it{event1.instance_variable_get("@event_name").should eq "First of September"}
  it{event1.instance_variable_get("@event_time").should eq Time.new(2013,9,1)}

  it "should test elapsed time from event" do
    Timecop.freeze(Time.new(2013,9,2)) do
      puts "debug in #{__FILE__} at #{__LINE__} : Time.now == #{Time.now}"
      event1.to_s.should eq "First of September 1 day ago"
    end
  end
  
  it "should test elapsed time until event" do
    Timecop.freeze(Time.new(2013,8,31)) do
      puts "debug in #{__FILE__} at #{__LINE__} : Time.now == #{Time.now}"
      event1.duration.should eq "First of September in 1 day"
    end
  end

  context "events with times" do
    let(:event2) {ElapsedWatch::Event.new("Quit Smoking: 2013-09-07 17:00")}
    it{event2.instance_variable_get("@event_name").should eq "Quit Smoking"}
    it{event2.instance_variable_get("@event_time").should eq Time.new(2013,9,7,17)}
    it "should show elapsed time since event" do
      Timecop.freeze(Time.new(2013,9,16,20,22,3)) do
        event2.to_s.should eq "Quit Smoking 9 days 3 hrs 22 mins 3 secs ago"
      end
    end
    it "should show elapsed time for one year from event" do
      Timecop.freeze(Time.new(2014,9,7,17)) do
        event2.to_s.should eq "Quit Smoking 1 yr ago"
      end
    end
  end

  context "events with only year given" do
    let(:event3) {ElapsedWatch::Event.new("Birth Year: 1957")}
    it{event3.instance_variable_get("@event_name").should eq "Birth Year"}
    it{event3.instance_variable_get("@event_time").should eq Time.new(1957)}
  end

  context "events with only MM-DD given" do
    let(:event4) {ElapsedWatch::Event.new("Birthday: 10-12")}
    it{event4.instance_variable_get("@event_name").should eq "Birthday"}
    it{event4.instance_variable_get("@event_time").should eq Chronic.parse("10-12")}
  end

  


  context "sad paths" do
    it "event without a date should fail" do
      expect {ElapsedWatch::Event.new("No date:")}.to raise_error RuntimeError
    end
    it "event with empty string for date spec should fail" do
      expect {ElapsedWatch::Event.new("Empty string: ''")}.to raise_error RuntimeError
    end
    it "event with empty name should fail" do
      expect {ElapsedWatch::Event.new(": 2013-09-01")}.to raise_error Psych::SyntaxError
    end
    it "event with unparsable time spec should have nil time" do
      event5 = ElapsedWatch::Event.new("Bad spec: another fine mess")
      event5.instance_variable_get("@event_time").should be_nil
    end


  end
  
  context "class method parse" do
    it{ElapsedWatch::Event.should respond_to :parse}
    context "should return an ElapsedWatch::Event object" do
      let(:event) {ElapsedWatch::Event.parse "Parsed event: 2026-10-12" }
      it {event.should be_a ElapsedWatch::Event}
      it {event.instance_variable_get("@event_name").should eq "Parsed event"}
      it {event.instance_variable_get("@event_time").should eq Time.new 2026,10,12}
    end

  end



end
