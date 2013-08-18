require 'yaml'
require 'realstats/queue'
require 'realstats/server'
require 'realstats/ws'

module RealStats
  def self.settings
    YAML.load(File.read("config/settings.yml"))
  end
end
