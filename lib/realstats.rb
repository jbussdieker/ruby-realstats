require 'yaml'
require 'realstats/queue'
require 'realstats/server'
require 'realstats/web_socket'

module RealStats
  def self.settings
    YAML.load(File.read("config/settings.yml"))
  end

  def self.queue
    RealStats::Queue.new(settings[:queue])
  end

  def self.web_socket_server
    RealStats::WebSocket.new(settings[:websocket])
  end
end
