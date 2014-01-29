
default:

# need to run as sudo -u postgres
database:
	cd sql; sudo -u postgres ./createdb.sh

run:
	python3.3 src/jobqueue.py

test:
	./run-tests.sh

# docker targets probably require running make using sudo
docker-build:
	docker build -t jobqueue .

# run detached, remap rabbitmq to port 5673
docker-run:
	docker run -d -p 127.0.0.1:5673:5672 -p 127.0.0.1:8314:8314 -t jobqueue

docker-run-interactive:
	docker run -i -p 127.0.0.1:5673:5672 -p 127.0.0.1:8314:8314 -t jobqueue /bin/bash

docker-test:
	docker run -t jobqueue /jobqueue/container-test.sh
