#! /bin/bash

function	install()
{
	echo 	"Attempting to install $1"
	if [ -x "$(command -v apt-get)" ]; then
		apt-get update;
		apt-get install -y "$1";
		apt-get clean;
	else
		exit 2;
	fi
}

which nginx &> /dev/null || exit $?;

nginx -t &> /dev/null || exit $?;

if which service &> /dev/null; then
	service nginx status &> /dev/null || exit $?;
else
	install "init"
fi

if which nc &> /dev/null; then
	nc -zv wordpress 9000 &> /dev/nul || exit $?;
else
	install "netcat"
fi

exit 0;
