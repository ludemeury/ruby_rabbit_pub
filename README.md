# RabbitMQ ruby pub

1. Config ENVS

```
export RABBIT_MQ_HOST="domain.abc"
export RABBIT_MQ_V_HOST="vhost"
export RABBIT_MQ_USER="user"
export RABBIT_MQ_PASSWORD="passs"
export RABBIT_MQ_PORT="5672"
export RABBIT_MQ_QUEUE="queue_name"
```

2. Install GEM
```
gem install bunny -v 1.7.1
```

2. Run
````
ruby sender.rb
