#!/usr/bin/env ruby
require 'realstats'

queue = RealStats.queue

ARGF.each do |metric|
  queue.publish(metric)
end
