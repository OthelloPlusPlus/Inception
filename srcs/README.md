# Inception - Docker Compose
Docker Compose is a tool for defining and running multi-container Docker applications. It uses a YAML file to define the services, networks, and volumes required for an application and allows you to start, stop, and manage the entire application stack with a single command. Docker Compose simplifies the orchestration of complex applications by providing a declarative syntax for defining the application configuration and automating common tasks like container linking and network setup.

# Table of Contents
- [Commands](#commands)
- [docker-compose.yml](#docker-compose.yml)
  - [version](#version)
  - [services](#services)
  - [networks](#networks)
  - [volumes](#volumes)
  - [secrets](#secrets)
  - [configs](#configs)

# Commands
```Makefile
start:
    docker-compose up       # Build, create, start, and attach to containers for a service.
    docker-compose build    # Build or rebuild services defined in the `docker-compose.yml` file.
    docker-compose create   # Create services defined in the `docker-compose.yml` file.
    docker-compose start    # Start services.

stop:
    docker-compose down     # Stop and remove containers, networks, volumes, and images created by `docker-compose up`.
    docker-compose rm       # Remove stopped containers.
    docker-compose stop     # Stop services.
    docker-compose kill     # Forcefully stop services.
    docker-compose restart  # Restart services.

interact:
    docker-compose run      # Run a one-off command in a service container.
    docker-compose exec     # Run a command in a running service container.
    docker-compose pause    # Pause services.
    docker-compose unpause  # Unpause services.

inspect:
    docker-compose images   # List images used by services.
    docker-compose ps       # List running services.
    docker-compose top      # Display the running processes of a service.
    docker-compose logs     # View output from services.

manage:
    docker-compose pull     # Pull images for services from the Docker Hub.
    docker-compose push     # Push images for services to the Docker Hub.
    docker-compose config   # Validate and view the Docker Compose file.
    docker-compose scale    # Set the number of containers for a service.
    docker-compose events   # Receive real-time events from containers.
    docker-compose port     # Print the public port for a service's container.
    docker-compose version  # Show the Docker-Compose version information.
```

# docker-compose.yml

## version
The version section specifies the version of the Docker Compose file format being used. 
It determines which features and syntax are available for defining services, networks, volumes, and other configurations in the Docker Compose file.
```yml
version: '3.8'
```
## services
The services section defines the containers that make up the application. 
Each service represents a containerized component of the application, such as a web server, database, or worker process. 
Services can be configured with various options, including the Docker image to use, ports to expose, volumes to mount, dependencies, and more.
```yml
services:
  web:
    # Crucial Configuration Options
    image: nginx:latest  # Specifies the Docker image to use for the service.
    container_name: web_container  # Sets the name of the container.
    ports:  # Exposes ports from the container to the host system.
      - "8080:80"  # Maps port 80 inside the container to port 8080 on the host.

    # Important Configuration Options
    volumes:  # Specifies volumes to mount into the container.
      - ./nginx.conf:/etc/nginx/nginx.conf  # Mounts the local nginx.conf file into the container.
    networks:  # Defines which networks the service should be connected to.
      - frontend  # Connects to the frontend network.
      - backend   # Connects to the backend network.
    depends_on:  # Specifies dependencies between services.
      - db  # Indicates that the service depends on the db service.
  
    # Optional Configuration Options
    build:  # Specifies the build context for building a custom Docker image.
      context: ./path/to/build/context  # Specifies the build context directory.
      dockerfile: Dockerfile  # Specifies the Dockerfile to use for building the image.
    environment:  # Specifies environment variables directly.
      - POSTGRES_DB=mydatabase  # Sets the name of the database to "mydatabase".
      - POSTGRES_USER=myuser     # Sets the username for accessing the database.
      - POSTGRES_PASSWORD=mypassword  # Sets the password for accessing the database.
    env_file:  # Specifies an external file containing environment variables.
      - ./db.env  # Specifies the file containing the environment variables.
    entrypoint:  # Overrides the default entrypoint specified by the Docker image.
      - "/bin/bash"  # Specifies the entrypoint command.
    command:  # Overrides the default command specified by the Docker image.
      - "--option"  # Specifies the command to execute.
    extra_hosts:  # Adds additional hostnames to resolve inside the container.
      - "host1:192.168.0.1"  # Maps hostname "host1" to IP address "192.168.0.1".
    labels:  # Adds metadata to the container.
      - com.example.description="Database container"  # Adds a description label.
      - com.example.department="IT"  # Adds a department label.
    restart:  # Defines the restart policy for the service.
      unless-stopped  # Restarts the container unless explicitly stopped.
    secrets:  # Specifies secrets to be passed to the service.
      - db_password  # Specifies the name of the secret.
    user:  # Sets the user or UID for the container.
      1000:1000  # Specifies the user and group IDs.
    working_dir:  # Sets the working directory for the command.
      /app  # Specifies the working directory path.
    privileged:  # Gives the container full access to the host system.
      true  # Enables privileged mode.
    cap_add:  # Adds Linux capabilities.
      - SYS_ADMIN  # Adds the SYS_ADMIN capability.
    cap_drop:  # Drops Linux capabilities.
      - NET_ADMIN  # Drops the NET_ADMIN capability.
    devices:  # Allows the container to access host devices.
      - "/dev/sda:/dev/xvda:rwm"  # Maps the host device to the container device.
    dns:  # Sets custom DNS servers for the container.
      - 8.8.8.8  # Sets Google's DNS server.
      - 8.8.4.4  # Sets Google's backup DNS server.
    healthcheck:  # Defines a health check for the service.
      test: ["CMD", "curl", "-f", "http://localhost/"]  # Specifies the command to check the health.
      interval: 1m  # Sets the interval between health checks.
      timeout: 10s   # Sets the timeout for health checks.
      retries: 3     # Sets the number of retries before considering the container unhealthy.
      start_period: 40s  # Sets the start period for health checks.
    logging:  # Specifies logging options for the container.
      driver: syslog  # Sets the logging driver to syslog.
      options:  # Specifies additional logging options.
        syslog-address: "tcp://192.168.1.10:123"
    stop_signal:  # Specifies the signal to stop the container.
      SIGTERM  # Sets the stop signal to SIGTERM.
```

## networks
The networks section defines custom networks for the services. 
Networks facilitate communication between containers in a Docker Compose environment. 
Services can be connected to one or more networks, allowing them to communicate with each other securely.
```yml
networks:
  frontend:
    # Crucial Configuration Options
    driver: bridge  # Specifies the driver type for the network.
    
    # Important Configuration Options
    ipam:  # IP Address Management configuration for the network.
      driver: default  # Specifies the IPAM driver.
      config:  # Specifies IP address configuration for the network.
        - subnet: "192.168.0.0/24"  # Specifies the subnet for the network.
        - gateway: "192.168.0.1"  # Specifies the gateway for the network.
    attachable: true  # Enables attachable mode for the network, allowing other services to attach to it.
    
    # Optional Configuration Options
    enable_ipv6: true  # Enables IPv6 support for the network.
    internal: false  # Specifies whether the network should be internal-only.
    labels:  # Adds metadata labels to the network.
      - com.example.description="Frontend network"  # Adds a description label.
      - com.example.department="IT"  # Adds a department label.
    external: true  # Specifies whether the network is external.
    name: custom_frontend_network  # Specifies a custom name for the network.
    driver_opts:  # Specifies additional options for the network driver.
      com.docker.network.bridge.name: "custom_bridge"  # Sets the name of the network bridge.
      com.docker.network.bridge.enable_ip_masquerade: "true"  # Enables IP masquerading.
      com.docker.network.bridge.host_binding_ipv4: "0.0.0.0"    # Specifies the IPv4 address to bind to.
      com.docker.network.bridge.enable_ip6: "true"   # Enables IPv6 for the network.
      com.docker.network.driver.mtu: "1500"          # Sets the maximum transmission unit (MTU) for the network.
```

## volumes
The volumes section defines named volumes for persisting data used by services. 
Volumes provide a way to store and share data between containers, ensuring data persistence and facilitating data management in a Docker environment.
```yml
volumes:
  data_volume:
    # Crucial Configuration Options
    driver: local  # Specifies the driver type for the volume.
    
    # Important Configuration Options
    driver_opts:  # Options specific to the volume driver.
      type: "nfs"  # Specifies the type of volume to create.
      o: "addr=192.168.1.10,rw,nolock"  # Specifies additional options for the volume.
    
    # Optional Configuration Options
    external: true  # Specifies whether the volume is external.
    name: custom_data_volume  # Specifies a custom name for the volume.
    labels:  # Adds metadata labels to the volume.
      - com.example.description="Data volume"  # Adds a description label.
      - com.example.department="IT"  # Adds a department label.
    driver_opts:  # Specifies additional options for the volume driver.
      type: "local"  # Specifies the type of volume to create.
      device: "/dev/xvdf"  # Specifies the device to use for the volume.
      o: "bind"  # Specifies additional options for the volume.
```

## secrets
The secrets section defines sensitive data that should be securely passed to services. 
Secrets allow you to manage and distribute sensitive information, such as passwords or API keys, without exposing them in plain text in the Docker Compose file.
```yml
secrets:
  db_password:
    # Crucial Configuration Options
    file: ./db_password.txt  # Specifies the file containing the secret data.
    
    # Important Configuration Options
    external: true  # Specifies whether the secret is external and managed outside of Docker Compose.
    
    # Optional Configuration Options
    name: custom_db_password_secret  # Specifies a custom name for the secret.
    labels:  # Adds metadata labels to the secret.
      - com.example.description="Database password"  # Adds a description label.
      - com.example.department="IT"  # Adds a department label.
```

## configs
The configs section defines configuration files or data to be shared among services. 
Configs allow you to manage configuration data separately from the Docker Compose file, making it easier to update and maintain configuration settings for your services.
```yml
configs:
  nginx_config:
    # Crucial Configuration Options
    file: ./nginx.conf  # Specifies the file containing the configuration data.
    
    # Important Configuration Options
    external: true  # Specifies whether the config is external and managed outside of Docker Compose.
    
    # Optional Configuration Options
    name: custom_nginx_config  # Specifies a custom name for the config.
    labels:  # Adds metadata labels to the config.
      - com.example.description="Nginx configuration"  # Adds a description label.
      - com.example.department="IT"  # Adds a department label.
```
