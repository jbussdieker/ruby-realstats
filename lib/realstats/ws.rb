require 'em-websocket'
require 'bunny'
require 'json'

module RealStats
  class WS
    def initialize
      @conn = Bunny.new("amqp://admin:password@localhost:5672")
      @conn.start
      @queue = @conn.queue("realstats", :arguments => {"x-message-ttl" => 5})
      @list = []
    end

    def run_client(ws)
      Thread.new do
        @queue.subscribe(:block => true) do |message,header,body|
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
