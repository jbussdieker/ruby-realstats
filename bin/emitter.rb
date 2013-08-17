#!/usr/bin/env ruby
require 'bunny'

conn = Bunny.new("amqp://admin:password@localhost:5672")
conn.start
ch = conn.create_channel
q = ch.queue("realstats", {:arguments => {"x-message-ttl" => 5}})

ARGF.each do |line|
  q.publish(
    line.strip, 
    :expiration => 5
  )
end
