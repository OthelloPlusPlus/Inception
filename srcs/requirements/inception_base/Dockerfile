# Pulling Debian
# 	Versions	https://www.debian.org/releases/
#		12.0	Bookworm (Stable)
#		11.7	Bullseye (Penultimate)
#		10.13	Buster	(oldoldstable)
FROM	debian:bullseye
LABEL	_author="Othello"\
		_project="Inception"

RUN		apt-get update \
	&&	apt-get install -y \
			apt-utils \
			gettext-base

# For Connection info:
# apt-get install -y tcpdump
# tcpdump -i <interface> -A -s 0 'tcp port 80'