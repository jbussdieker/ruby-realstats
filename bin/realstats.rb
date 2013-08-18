#!/usr/bin/env ruby
require 'realstats'

Thread.new do
  RealStats.web_socket_server.run
end

RealStats.web_server.run
