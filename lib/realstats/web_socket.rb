require 'em-websocket'
require 'json'

module RealStats
  class WebSocket
    def initialize(options = {})
      @queue = RealStats.queue
      @host = options[:host] || "0.0.0.0"
      @port = options[:port] || 8080
      @list = []
    end

    def run_client(ws)
      Thread.new do
        @queue.subscribe do |message,header,body|
          ws.send(body.to_json)
        end
      end
    end

    def run
      EM.run do
        EM::WebSocket.run(:host => @host, :port => @port) do |ws|
          ws.onopen do |handshake|
            puts "WebSocket connection open"
            run_client(ws)
          end

          ws.onclose do
            puts "Connection closed"
          end
        end
      end
    end
  end
end
