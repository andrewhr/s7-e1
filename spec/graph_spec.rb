require 'spec_helper'

describe Graph do

  before(:each) do
    last_status = [
      Status::Process.new(2, "cmd2", "user", 0.42),
      Status::Process.new(1, "cmd1", "user", 0.0)
    ]
    current_status = [
      Status::Process.new(1, "cmd1", "user", 3.023),
      Status::Process.new(2, "cmd2", "user", 0.42)
    ]
    history = History.new([last_status, current_status])
    @graph = Graph.new(history)
  end

  it "prints a entry for each process" do
    @graph.to_s.should match(/cmd1/m)
    @graph.to_s.should match(/cmd2/m)
  end

  it "prints command user" do
    @graph.to_s.lines.each { |l| l.should match(/user/m) }
  end

  it "prints command name" do
    @graph.to_s.should match(/cmd1/m)
    @graph.to_s.should match(/cmd2/m)
  end

  it "prints CPU percentage" do
    @graph.to_s.should match(/3\.02%/m)
    @graph.to_s.should match(/0\.42%/m)
  end

  it "prints a '^' as a up marker for processes that has been ranked up" do
    @graph.to_s.should match(/^\^.*cmd1.*$/m)
  end

  it "prints a 'v' as a down marker for processes that has been ranked down" do
    @graph.to_s.should match(/^v.*cmd2.*$/m)
  end

end
