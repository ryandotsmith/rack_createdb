# Purpose

I am using this app to share my database to the attendees of my training session at Red Dirt Ruby Conf.
Each client that sends a request to this server will have a database provisioned for them. I am keeping
track of the database based upon the senders IP Address.

# Useage

## Server

rackup

## Client

    # if server ip = 10.0.0.1

    curl http://10.0.0.1

    # => postgres://red_dirt_user:ruby@10.0.0.1/red_dirt_database_1
