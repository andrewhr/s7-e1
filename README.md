### Process Status

This gem wraps the ps program, so you can get process information inside a ruby program.

The gem ships with a command called psgraph. You can use it to view a
auto-refreshed ps, that can notify about cpu hungry programs. For sake
of simplicity and to become more easy to test, "hungry programs" are
every program that become using more than 15% of CPU in some single
ps-snapshot. In Mac you could easy achieve that scrolling throught
Activity Monitor.

### Pre-requisites

Growl must be installed in system, since the application sends growl
notifications. Requires “Listen for incoming notifications” to be enabled
(in preferences pane).

### Examples

To get access to processes, just use a new instance of Status class.

    require 'process_status'
    
    status = Status.new
    processes = status.processes

Each process has pid, user, cpu usage and command.  The library also has some 
helpers to deal with the process list: History, that deals with ranking
processes (according with its cpu usage) and Graph, for nice History
output:

    history = History.new(processes)
    
    # returns if that process (by pid) has been ranked up or down
    history.process_rank(processes.first.pid) 
    
    # returns all processes with cpu usage above the Hungry Thereshold
    history.hungry_processes
    
    # gets a nice formating for history
    graph = Graph.new(history)
    puts graph

