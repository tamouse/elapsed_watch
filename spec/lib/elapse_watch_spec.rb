require 'spec_helper'

describe ElapsedWatch do
  it "should have a version number" do
    ElapsedWatch::VERSION.should_not be_nil
  end
  it {should respond_to :run}
  context "running the ElapsedWatch" do
    before(:each) do
      File.stub(:read => "Event One: 2001-01-01\nEvent Two: 2013-12-31")
    end
    let(:results) {ElapsedWatch.run(nil)}
    it {results.should be_an Array}
    it {results.size.should eq 2}
    it {results[0].should be_a String}
    it {results[0].should match /^Event One/}
    it {results[1].should be_a String}
    it {results[1].should match /^Event Two/}
 
  end

end
