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
notifications.
