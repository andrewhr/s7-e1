module ProcessStatus

  class Status

    def processes
      output = popen("-eo user,pcpu,pid,command")

      processes = []
      output.lines.each_with_index do |line, index|
        next if index == 0
        processes << parse_process(line)
      end
      processes
    end

    private

    Process = Struct.new :user, :cpu_usage, :pid, :command

    def parse_process(string)
      process_regex = %r{
        (?<user> \w+ ){0}
        (?<cpu_usage> \d{1,2}\.\d ){0}
        (?<pid> \d+ ){0}
        (?<command> .* ){0}

        ^\g<user>\s+\g<cpu_usage>\s+\g<pid>\s+\g<command>$
      }x
      attributes = string.match(process_regex)
      cpu_usage = attributes[:cpu_usage].to_f / 100
      pid = attributes[:pid].to_i
      Process.new attributes[:user], cpu_usage, pid, attributes[:command]
    end

  end

end
