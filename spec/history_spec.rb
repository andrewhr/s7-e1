require 'spec_helper'

describe History do

  before(:each) do
    last_status = [
      Status::Process.new(2, "cmd2", "user", 0.42),
      Status::Process.new(3, "cmd3", "user", 0.1),
      Status::Process.new(1, "cmd1", "user", 0.0)
    ]
    current_status = [
      Status::Process.new(1, "cmd1", "user", 3.023),
      Status::Process.new(3, "cmd3", "user", 1.0),
      Status::Process.new(2, "cmd2", "user", 0.42)
    ]
    @history = History.new [last_status, current_status]
  end

  it "calculates if processes have gone up" do
    @history.process_rank(1).should == :up
  end

  it "calculates if processes have gone down" do
    @history.process_rank(2).should == :down
  end

  it "calculates if processes have stay at same position" do
    @history.process_rank(3).should == :unchanged
  end

  it "ranks up new processes that appear in current status" do
    @history.process_rank(4).should == :up
  end

  it "ranks down processes that are gone in current status" do
    @history.current.delete_at(0)
    @history.process_rank(1).should == :down
  end

  it "categorizes as hungry processes that are using more than 15% cpu" do
    hungry_one = Status::Process.new(42, "yummy!", "user", 15.0)
    @history.current << hungry_one
    @history.hungry_processes.should include(hungry_one)
  end

end
