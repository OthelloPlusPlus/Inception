#! /bin/bash

# =====================================||===================================== #
#																			   #
#								 Configuration								   #
#																			   #
# ==============Inception==============||==============©Othello=============== #

C_RESET="\x1b[0m"
C_BOLD="\x1b[1m"
C_DGRAY="\x1b[38;2;64;64;64m"
CB_ORANGE="\x1b[48;2;255;128;0m"

clear
trap	'errorHandler "$BASH_COMMAND"' ERR
trap	'echo "Received termination signal.";
		echo "Stopping child process...";pkill -P $$;
		echo "Stopping script..."; exit;' SIGINT SIGTERM

SHOWALL=false
for arg in "$@"; do
	case $arg in
		-a | --all | all)
			SHOWALL=true;;
		-h | --help | help)
			echo "Add the -h flag to show all";
			exit 0;;
		*)
			echo "Error: Bad flag. Use -h for more information."
			exit 1;;
	esac
done

# =====================================||===================================== #
#																			   #
#								   Functions								   #
#																			   #
# ==============Inception==============||==============©Othello=============== #

function seperateHidden()
{
	HEADER=true;
	BASE=$(echo "$2" | tr -d ' ')
	if [ "$SHOWALL" = true ]; then
		FULL="$3";
	else
		FULL="$2"
	fi

	BUFFER+="$C_RESET$C_BOLD $1\n"
	while IFS= read -r base_line; do
		COMP=$(echo "$base_line" | tr -d ' ')
		BUFFER+="$C_RESET"
		if [ "$HEADER" = true ]; then
			BUFFER+="$CB_ORANGE"
			HEADER=false
		elif ! printf "%s" "$BASE" | grep -qwF "$COMP"; then
			BUFFER+="$C_DGRAY"
		fi
		BUFFER+="$base_line\n"
	done <<< "$FULL"
	BUFFER+="$C_RESET\n"
}

function updateScreen()
{
	BUFFER=""
	seperateHidden	"Images"		"$(docker images)"	"$(docker images -a)"
	seperateHidden	"Containers"	"$(docker ps)"		"$(docker ps -a)"
	seperateHidden	"Volumes"		"$(docker volume ls)"		"$(docker volume ls)"
	seperateHidden	"Networks"		"$(docker network ls --filter type=custom)"		"$(docker network ls)"
	clear
	echo -e -n "$BUFFER"
}

function	errorHandler()
{
	STATUS="$?"
	echo "Error[$STATUS]: $1" >&2
	exit $STATUS
}

# =====================================||===================================== #
#																			   #
#									 Script									   #
#																			   #
# ==============Inception==============||==============©Othello=============== #

docker events | while read -r event; do
    updateScreen
done & 
while true; do
	updateScreen
	sleep 10
done
