module ProcessStatus

  class History

    HUNGRY_PROCESS_THERESHOLD = 15.0

    def initialize(status = nil)
      timeline.concat Array(status) if status
    end

    def << (status)
      timeline << status
    end

    def each
      current.each do |process|
        yield(process)
      end
    end

    def process_rank(pid)
      current_index = current.find_index { |p| p.pid == pid }

      last_status = timeline[-2] || current
      last_index = last_status.find_index { |p| p.pid == pid }

      if last_index
        # remember: the status list are expected to be sorted descending!
        if current_index.nil? or last_index < current_index
          return :down
        elsif last_index == current_index
          return :unchanged
        end
      end
      :up
    end

    def hungry_processes
      current.select { |p| p.cpu_usage >= HUNGRY_PROCESS_THERESHOLD }
    end

    def current
      @timeline.last
    end

    def timeline
      @timeline ||= []
    end

  end

end
