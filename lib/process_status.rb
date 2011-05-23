require 'process_status/status'
require 'process_status/history'
require 'process_status/graph'
require 'process_status/growl'

module ProcessStatus

  class Runner

    def self.start
      status = Status.new
      history = History.new

      loop do
        system('clear')

        history << status.processes.first(10)

        graph = Graph.new(history)
        puts graph

        notify history.hungry_processes unless history.hungry_processes.empty?

        sleep 1
      end
    end

    def self.notify(processes)
      message = "The following process are consuming too much cpu resources: "
      processes.each do |p|
        Growl.growl("Warning!", message + "#{p.command} (#{p.user})")
      end
    end

  end

end
