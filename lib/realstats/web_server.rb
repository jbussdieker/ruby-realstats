require 'sinatra/base'

module RealStats
  class WebServer < Sinatra::Base
    set :public_folder, File.expand_path('../../../public', __FILE__)
    set :views, File.expand_path('../../../views', __FILE__)

    get '/' do
      erb :index
    end

    def self.run
      Rack::Handler::WEBrick.run(RealStats::WebServer, RealStats.settings[:webserver]) do |server|
        [:INT, :TERM].each { |sig| trap(sig) { server.stop } }
      end
    end
  end
end
