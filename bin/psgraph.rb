#!/usr/bin/env ruby

$:.unshift(File.join(File.dirname(File.dirname(__FILE__)), 'lib'))
require 'process_status'

ProcessStatus::Runner.start
