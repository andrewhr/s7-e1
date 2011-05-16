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
    @status.should_receive(:popen) { PROCESS_OUTPUT }
  end

  it "retrieves all running processes" do
    @status.processes.count.should == 6
  end

  describe "and for each process" do

    before(:each) do
      @process = @status.processes.first
    end

    it "retrives process user" do
      @process.user.should == 'root'
    end

    it "retrives process percentage of CPU usage" do
      @process.cpu_usage.should == 0.017
    end

    it "retrives process start time" do
      @process.pid.should == 1
    end

    it "retrives process command" do
      @process.command.should == "/sbin/launchd"
    end

  end

end
