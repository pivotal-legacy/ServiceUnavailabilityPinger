# Service Unavailability Pinger (SUP)

## What is it
SUP is a simple app that demonostrates how to use (Sneakers)[https://github.com/jondot/sneakers]
as a Job queue for Rails.


## Install

 * Clone the repo and `bundle`. SUP is based on PostgreSQL.
 * Install RabbitMQ

 ```bash
$ brew install rabbitmq
```

## Start

 * Start RabbitMQ
 * Start with Foreman

 ```bash
$ foreman start
```

## Try it out!

Visit your application, and hit the `enqueue new polling job` button.
Refresh the page at will.
