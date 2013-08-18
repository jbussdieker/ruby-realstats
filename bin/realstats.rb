#!/usr/bin/env ruby
require 'realstats'

Thread.new do
  RealStats.web_socket_server.run
end

Rack::Handler::WEBrick.run(RealStats::Server, RealStats.settings[:webserver]) do |server|
  [:INT, :TERM].each { |sig| trap(sig) { server.stop } }
end
