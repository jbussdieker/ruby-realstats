require 'yaml'
require 'realstats/queue'
require 'realstats/web_socket'
require 'realstats/web_server'

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

  def self.web_server
    RealStats::WebServer
  end
end
