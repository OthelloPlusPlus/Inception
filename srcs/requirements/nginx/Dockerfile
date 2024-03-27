FROM inception:base

# Installation
RUN	apt-get install -y --fix-missing \
			nginx \
			openssl \
	&&	apt-get clean \
	&&	rm -rf /var/lib/apt/lists/*

# Setting up TLSv1.3
#	-x509	Generate Selfsigned certificate
#	-nodes	No password encryption
#	-days	Duration
#	-newkey	Generate 2048 bit key with RSA encryption algorithm 
#	-keyout	Key location
#	-out	Certificate location
#	-subj	Subject Distinguised Name
#			C	Country	
#			ST	State
#			L	Location
#			O	Organisation
#			OU	Organisational Unit
#			CN	Common Name/Domain
RUN		mkdir /etc/nginx/ssl \
	&&	openssl req	-x509 \
					-nodes \
					-days 365 \
					-newkey rsa:2048 \
					-keyout /etc/nginx/ssl/private.key \
					-out	/etc/nginx/ssl/certificate.crt \
					-subj	"/C=NL/ST=ZH/L=AMS/O=CODAM/OU=Student/CN=ohengelm.42.fr"

# Import
#	Copy with symbolic link
COPY	conf/wordpress.conf	/etc/nginx/sites-available/wordpress.conf
RUN		ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/

COPY	/tools/health_daemon.sh	/usr/local/bin/health_daemon.sh
RUN		chmod +x /usr/local/bin/health_daemon.sh

EXPOSE	443
HEALTHCHECK	--interval=1m --timeout=10s --retries=3 \
			CMD ["/usr/local/bin/health_daemon.sh"]

# Bootup
CMD	["nginx", "-g", "daemon off;"]
# CMD ["tail", "-f", "/dev/null"]
