require 'spec_helper'

PROCESS_OUTPUT = <<OUT
USER      %CPU   PID COMMAND
root       1.7     1 /sbin/launchd
root       0.0    10 /usr/libexec/kextd
root       0.0    11 /usr/sbin/notifyd
root       0.0   232 login -pf andrewhr
andrewhr   0.0   233 -bash
andrewhr   2.8   225 /Applications/Safari.app/Contents/MacOS/Safari -psn_0_110619
OUT

describe Status do

  before(:each) do
    @status = Status.new
    IO.should_receive(:popen).and_return(PROCESS_OUTPUT)
  end

  it "retrieves all running processes" do
    @status.processes.count.should == 6
  end

  it "retrives processes sorted in reverse order" do
    status = @status.processes
    status.each_with_index do |p, index|
      next if index == 0
      p.cpu_usage.should <= status[index - 1].cpu_usage
    end
  end

  describe "and for each process" do

    before(:each) do
      @process = @status.processes.first
    end

    it "retrives process user" do
      @process.user.should == 'andrewhr'
    end

    it "retrives process percentage of CPU usage" do
      @process.cpu_usage.should == 2.8
    end

    it "retrives process id" do
      @process.pid.should == 225
    end

    it "retrives process command" do
      @process.command.should == "/Applications/Safari.app/Contents/MacOS/Safari -psn_0_110619"
    end

  end

end
