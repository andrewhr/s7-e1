require 'bundler/setup'
require 'process_status'

RSpec.configure do |c|
  include ProcessStatus
end
