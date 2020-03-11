#!/bin/bash

VERSION=1.0.0
ACTION=${1}


function display_help() {
cat << EOF
Usage: ${0} {-r|--remove|-h|--help|-v|--version}
	Options:
		${0}		Updates packages, installs nginx, config nginx to start on instance start, and start server
		-r|--remove 	Stop server, empty html dir, and uninstall nginx
		-h|--help 	Shows help page
		-v|--version	Shows version
EOF
}

function install_and_start() {
	yum update -y
	amazon-linux-extras install nginx1.12 -y
	chkconfig nginx on
	service nginx start
}

function stop_and_uninstall() {
	service nginx stop
	rm /usr/share/nginx/html/*
	yum remove nginx -y
}

case "$ACTION" in
	"")
		install_and_start
		;;
	-r|--remove)
		stop_and_uninstall
		;;
	-h|--help)
		display_help
		;;
	-v|--version)
		echo VERSION
		;;
	*)
		echo "Usage: ${0} {-r|--remove|-h|--help|-v|--version}"
		exit 1
esac
