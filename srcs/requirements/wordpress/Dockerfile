# Pulling Debian
# 	Versions	https://www.debian.org/releases/
#		12.4	Bookworm (Stable)
#		11.8	Bullseye (Penultimate)
#		10.13	Buster	(oldoldstable)
FROM	debian:bullseye

LABEL	_author="Othello"\
		_project="Inception"

RUN		apt-get update
RUN		apt-get install -y --fix-missing \
						php-fpm
RUN		apt-get clean \
	&&	rm -rf /var/lib/apt/lists/*

EXPOSE	9000

# CMD	["nginx", "-g", "daemon off;"]
CMD ["tail", "-f", "/dev/null"]
