module ProcessStatus

  class Status

    def processes
      output = IO.popen("ps -eo user,pcpu,pid,command")

      processes = []
      output.lines.each_with_index do |line, index|
        next if index == 0
        processes << parse_process(line)
      end
      processes.sort_by { |p| p.cpu_usage }.reverse
    end

    private

    Process = Struct.new :user, :cpu_usage, :pid, :command

    def parse_process(string)
      process_regex = %r{
        (?<user> [_\w]+ ){0}
        (?<cpu_usage> \d{1,2}\.\d ){0}
        (?<pid> \d+ ){0}
        (?<command> .* ){0}

        ^\g<user>\s+\g<cpu_usage>\s+\g<pid>\s+\g<command>$
      }x
      attributes = string.match(process_regex)
      Process.new attributes[:user], attributes[:cpu_usage].to_f, attributes[:pid].to_i, attributes[:command]
    end

  end

end
