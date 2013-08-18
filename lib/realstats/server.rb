require 'sinatra/base'

module RealStats
  class Server < Sinatra::Base
    set :public_folder, File.expand_path('../../../public', __FILE__)
  end
end
