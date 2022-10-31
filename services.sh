#!/bin/bash
#
#  Command Line Interface to start all services associated with the Smart Campus UFC
#

set -e
export USER_ID=$(id -u)
dockerCmd="docker-compose"

if (( $# < 1 )); then
    echo "Illegal number of parameters"
    echo "usage: services [create|start|stop|help]"
    exit 1
fi

stoppingContainers () {
	echo "Stopping running containers"
	${dockerCmd} -f docker-compose.yml down -v --remove-orphans
}

loadData () {
	waitForDatabase
	waitForKong	
	docker run --rm -v $(pwd)/data/provision-api.sh:/provision-api.sh \
		--network smartufc_core-net \
		--entrypoint /bin/ash curlimages/curl provision-api.sh
	echo ""
}

waitForDatabase () {
	echo -e "\n Waiting for \033[1mPostgres\033[0m to be available\n"
	while ! [ `docker inspect --format='{{.State.Health.Status}}' core-db` == "healthy" ]
	do 
		sleep 1
	done
}

waitForKong () {
	echo -e "\n Waiting for \033[1mKong\033[0m to be available\n"
	while ! [ `docker inspect --format='{{.State.Health.Status}}' core-kong` == "healthy" ]
	do 
		sleep 1
	done
}

command="$1"
case "${command}" in
	"help")
        echo "usage: services [create|start|stop]"    	 
		;;
	"stop")
		export $(cat .env | grep "#" -v)
		stoppingContainers
		;;
	"start")
		export $(cat .env | grep "#" -v)
		stoppingContainers
		echo -e "Starting containers"
		echo ""
		COMPOSE_PROFILES=database KONG_DATABASE=postgres ${dockerCmd} -f docker-compose.yml up -d
		loadData
		;;
	"create")
		export $(cat .env | grep "#" -v)
		echo "Pulling Docker images"
		docker pull curlimages/curl
		${dockerCmd} -f docker-compose.yml pull
		;;
	*)
		echo "Command not Found."
		echo "usage: services [create|start|stop|help]"
		exit 127;
		;;
esac
