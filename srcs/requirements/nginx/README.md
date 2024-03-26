# Inception - NGINX
NGINX is a high-performance, open-source web server and reverse proxy server software.
It's known for its efficiency in handling concurrent connections and serving static content quickly.
NGINX is often used as a load balancer, reverse proxy, or HTTP cache in front of web servers to improve performance, scalability, and reliability of web applications.
Additionally, NGINX is commonly utilized as a web server itself, capable of serving static and dynamic content while efficiently managing resources.
It's highly configurable and widely used in various web hosting setups, including serving websites, APIs, and microservices architectures.

# Table of Contents
- [Transport Layer Security](#transport-layer-security)
- [NGINX Configuration](#nginx-configuration)

# Transport Layer Security
TLS is a cryptographic protocol used to secure communication over a computer network, commonly used for securing data transfer between a web server and a client's web browser.
It is the successor to SSL (Security Sockers Layer) and often still referred to as such.
TLS ensures that data transmitted between the server and the client is encrypted and remains confidential, protecting it from eavesdropping and tampering by malicious actors.

Using the command-line tool [openssl req](nginx/Dockerfile#L27) a [self-signed](nginx/Dockerfile#L27) certificated is generated.
It generates a [private key](nginx/Dockerfile#L31) which is used for to encrypt and sign data, and a [certificate](nginx/Dockerfile#L28), which contains [server information](nginx/Dockerfile#L33) and a public key.

# NGINX Configuration
Each website available through NGINX has its configuration stored in /etc/nginx/sites-available.
The wordpress website has been enabled with a symbolic link to /etc/nginx/sites-enabled/.

<a href="nginx/conf/wordpress.conf" target="_blank"></a>
<table>
	<thead style="background-color: #C0C0C0;">
    <tr>
      <th>File</th>
      <th>Description</th>
      <th>Configuration Adjustments</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan=5><a href="nginx/conf/wordpress.conf" target="_blank">nginx.conf</a></td>
      <td rowspan=5>The main configuration file for NGINX.
        It contains global directives that apply to the entire NGINX server, including settings related to server behavior, performance tuning, logging, and other global parameters.
        It also includes directives for including additional configuration files.</td>
      <td>Set NGINX to listen to <a href="nginx/conf/wordpress.conf#L3" target="_blank">port 443</a> for both IPv4 and IPv6.</td>
    </tr>
    <tr><td>Set NGINX to use the <a href="nginx/conf/wordpress.conf#L8" target="_blank">TLSv1.2 and TLSv1.3 protocols</a>.</td></tr>
    <tr><td>Specifies the <a href="nginx/conf/wordpress.conf#L9" target="_blank>locations of the private key and certificate</a>.</td></tr>
    <tr><td>Specifies the websites <a href="nginx/conf/wordpress.conf#L12" target="_blank">basic information</a>.</td></tr>
    <tr><td>Sets the <a href="nginx/conf/wordpress.conf#L12" target="_blank">FastCGI</a> (Fast Common Gateway Interface) protocol to the WordPress website over port 9000.</td></tr>
  </tbody>
</table>
