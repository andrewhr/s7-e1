require 'process_status/status'
require 'process_status/history'
require 'process_status/graph'

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
        sleep 1
      end
    end
  end

end
