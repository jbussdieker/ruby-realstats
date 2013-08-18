require 'em-websocket'
require 'json'

module RealStats
  class WebSocket
    def initialize(options = {})
      @queue = RealStats.queue
      @host = options[:host] || "0.0.0.0"
      @port = options[:port] || 8080
      @list = []
      @clients = []
      run_client
    end

    def run_client
      Thread.new do
        @queue.subscribe do |message,header,body|
          @clients.each do |client|
            client.send(body.to_json)
          end
        end
      end
    end

    def run
      EM.run do
        EM::WebSocket.run(:host => @host, :port => @port) do |ws|
          ws.onopen do |handshake|
            puts "WebSocket connection open"
            @clients << ws
          end

          ws.onclose do
            @clients.delete(ws)
            puts "Connection closed"
          end
        end
      end
    end
  end
end
