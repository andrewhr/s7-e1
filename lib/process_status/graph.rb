module ProcessStatus

  class Graph

    def initialize(history)
      @history = history
    end

    def to_s
      string = ''
      @history.each do |process|
        marker = process_marker(@history, process)
        string << "#{marker} #{process.pid.to_s.ljust(8)} #{process.user.ljust(20)}\t#{process.cpu_usage.round(2).to_s}%\t#{process.command}\n"
      end
      string
    end

    private

    def process_marker(history, process)
      case history.process_rank(process.pid)
      when :up
        '^'
      when :down
        'v'
      else
        ' '
      end
    end

  end

end
