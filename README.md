![ScreenShot](https://raw.github.com/jbussdieker/ruby-realstats/master/public/screenshot.png)

Simple demonstration of collecting and graphing realtime stats using Flot and Web Sockets.

# Prerequisites

## RabbitMQ

    sudo apt-get install rabbitmq-server

/etc/rabbitmq/enabled_plugins

    [rabbitmq_management].

# Usage

Start the web frontend

    bundle exec bin/realstats.rb

Start sending metrics

    sudo varnishncsa -F "%{Varnish:time_firstbyte}x" | bundle exec bin/emitter.rb
