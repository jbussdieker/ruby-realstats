    sudo apt-get install rabbitmq-server

/etc/rabbitmq/enabled_plugins

    [rabbitmq_management].

Running

    sudo varnishncsa -F "%{Varnish:time_firstbyte}x" | bundle exec bin/emitter.rb
    bundle exec bin/ws.rb
    bundle exec rackup
