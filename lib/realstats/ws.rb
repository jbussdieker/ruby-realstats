require 'em-websocket'
require 'json'

module RealStats
  class WS
    def initialize
      @queue = Queue.new(RealStats.settings[:queue])
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
      EM.run {
        EM::WebSocket.run(:host => "0.0.0.0", :port => 8080) do |ws|
          ws.onopen { |handshake|
            puts "WebSocket connection open"
            run_client(ws)
          }

          ws.onclose { puts "Connection closed" }
        end
      }
    end
  end
end
