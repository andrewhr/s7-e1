require 'process_status/status'
require 'process_status/graph'

module ProcessStatus

  class Runner
    def self.start
      status = Status.new
      graph = Graph.new

      history = []
      loop do
        system('clear')
        history = [history.last, status.processes.first(10)]
        graph.print history
        sleep 1
      end
    end
  end

end
