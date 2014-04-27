# Blog & Neo4J

This is a blog application with Neo4j as database backend. I tried use controller as an initiator of business logic
and services as an actor of it. From services are called controller through callbacks. I use rails 3.2, because native
neo4j gem is not stable for rails 4.

## Instalation

You must have installed jruby.

run:

	rvm install jruby-1.7.11
	rvm use jruby-1.7.11
	bundle install
	rails s
	
## Tests

Test are written in RSpec. There are only for controller class.
