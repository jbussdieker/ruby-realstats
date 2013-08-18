#!/usr/bin/env ruby
require 'bunny'
require 'eventmachine'
require 'realstats'

@queue = RealStats::Queue.new(RealStats.settings[:queue])

=begin
@list = []

Thread.new do
  EM.run do
    EventMachine::PeriodicTimer.new(0.03) do
      begin
        total = 0.0
        @list.each do |item|
          total += item.to_f
        end
        avg = total / @list.length
        @queue.publish(avg.to_s)
        @list = []
      rescue Exception => e
        p e
      end
    end
  end
end
=end

ARGF.each do |line|
  @queue.publish(line)
end
