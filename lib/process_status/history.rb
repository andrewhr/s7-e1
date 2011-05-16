module ProcessStatus

  class History

    def initialize(status = nil)
      unless status.nil?
        if status.kind_of? Array
          timeline.concat(status)
        else
          timeline << status 
        end
      end
    end

    def << (status)
      timeline << status
    end

    def each
      current.each_with_index do |process, index|
        yield(process)
      end
    end

    def process_rank(pid)
      current_index = current.find_index { |p| p.pid == pid }

      last_status = timeline[-2] || current
      last_index = last_status.find_index { |p| p.pid == pid }

      unless last_index.nil?
        # remember: the status list are expected to be sorted descending!
        if current_index.nil? or last_index < current_index
          return :down
        elsif last_index == current_index
          return :unchanged
        end
      end
      :up
    end

    def current
      @timeline.last
    end

    def timeline
      @timeline ||= []
    end

  end

end
