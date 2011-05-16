module ProcessStatus

  class Graph

    def initialize(history)
      @history = history
    end

    def to_s
      string = ''
      @history.last.each_with_index do |process, index|
        marker = process_marker(@history, process, index)
        string << "#{marker} #{process.pid.to_s.ljust(8)} #{process.user.ljust(20)}\t#{process.cpu_usage.round(2).to_s}%\t#{process.command}\n"
      end
      string
    end

    private

    def process_marker(history, process, index)
      last_status = history[-2] || history.last
      last_index = last_status.find_index { |p| p.pid == process.pid }
      unless last_index.nil?
        # remember: the status list are expected to be sorted descending!
        if last_index < index
          return 'v'
        elsif last_index == index
          return ' '
        end
      end
      '^'
    end

  end

end
