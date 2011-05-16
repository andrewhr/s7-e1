require 'spec_helper'

describe Graph do

  before(:all) do
    ProcessMock = Struct.new :pid, :command, :user, :cpu_usage
  end

  before(:each) do
    last_status = [
      ProcessMock.new(2, "cmd2", "user", 0.42),
      ProcessMock.new(1, "cmd1", "user", 0.0)
    ]
    current_status = [
      ProcessMock.new(1, "cmd1", "user", 3.023),
      ProcessMock.new(2, "cmd2", "user", 0.42)
    ]
    @history = [last_status, current_status]
    @graph = Graph.new
  end

  it "prints a entry for each process" do
    $stdout.should_receive(:puts).twice
    @graph.print(@history)
  end

  it "prints command user" do
    $stdout.should_receive(:puts).with(/user/i).twice
    @graph.print(@history)
  end

  it "prints command name" do
    $stdout.should_receive(:puts).with(/cmd1/i)
    $stdout.should_receive(:puts).with(/cmd2/i)
    @graph.print(@history)
  end
  it "prints CPU percentage" do
    $stdout.should_receive(:puts).with(/3.02%/i)
    $stdout.should_receive(:puts).with(/0.42%/i)
    @graph.print(@history)
  end

  it "prints a '^' as a up marker for processes that has been ranked up" do
    $stdout.should_receive(:puts).with(/\^.*cmd1/i)
    $stdout.should_receive(:puts)
    @graph.print(@history)
  end

  it "prints a 'v' as a down marker for processes that has been ranked down" do
    $stdout.should_receive(:puts).with(/v.*cmd2/i)
    $stdout.should_receive(:puts)
    @graph.print(@history)
  end

end
