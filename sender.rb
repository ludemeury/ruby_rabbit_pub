#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bunny'
require 'json'

hostname = ENV['RABBIT_MQ_HOST']
vhost = ENV['RABBIT_MQ_V_HOST'] || '/'
user = ENV['RABBIT_MQ_USER']
password = ENV['RABBIT_MQ_PASSWORD']
port = (ENV['RABBIT_MQ_PORT'] || 5672).to_i
queue_name = ENV['RABBIT_MQ_QUEUE'] || 'queue_ruby_test'

p "connection with: #{hostname} - #{vhost} - #{user} - #{password} - #{port} - #{queue_name}"

connection = Bunny.new(hostname: hostname,
                       vhost: vhost,
                       user: user,
                       password: password,
                       port: port,
                       verify_peer: false,
                       network_recovery_interval: 1,
                       threaded: false)
connection.start

p "threaded #{connection.threaded} - automatically_recover #{connection.automatically_recover?} - network_recovery_interval"

channel = connection.create_channel

queue = channel.queue(queue_name, durable: true)

message = { 'device' => 123_456, 'time' => Time.now, 'latitude' => -0.23663017e2, 'lologitude' => -0.46563253e2 }

result = channel.default_exchange.publish(message.to_json, routing_key: queue.name, content_type: 'application/json')
puts "[x] Sent - #{result} - #{message}"

connection.close
