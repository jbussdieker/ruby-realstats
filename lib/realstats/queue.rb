require 'bunny'

module RealStats
  class Queue
    def initialize(options = {})
      @name = options[:name] || "realstats"
      @host = options[:host] || "localhost"
      @port = options[:port] || "5672"
      @user = options[:user] || "guest"
      @password = options[:password] || "guest"
    end

    def create_connection
      connection = Bunny.new("amqp://#{@user}:#{@password}@#{@host}:#{@port}")
      connection.start
      connection
    end
      
    def connection
      @connection ||= create_connection
    end

    def channel
      @channel ||= connection.create_channel
    end

    def queue
      @queue ||= channel.queue(@name, {:arguments => {"x-message-ttl" => 5}})
    end

    def publish(msg)
      queue.publish(msg)
    end

    def subscribe(&block)
      queue.subscribe(:block => true, &block)
    end
  end
end
