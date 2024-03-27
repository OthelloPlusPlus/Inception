# Inception - WordPress
WordPress is a free and open-source content management system (CMS) written in PHP.
It is one of the most popular platforms for creating websites, blogs, and online stores.
WordPress offers a user-friendly interface, customizable themes, and a vast ecosystem of plugins and extensions, making it versatile and adaptable for various types of websites.
It powers millions of websites worldwide and is known for its flexibility, scalability, and extensive community support.

# Table of Contents
- [WordPress Installation and Configuration](#wordpress-installation-and-configuration)
  - [WordPress Command Line Interface](wordpress-command-line-interface)
  - [Configuration File](#configuration-file)
- [PHP FastCGI Process Manager](#php-fastcgi-process-manager)

# WordPress Installation and Configuration
Unlike other processes, WordPress is not installed by use of apt-get. 
WordPress is seperately downloaded by wp-cli, which is also used for configuration.
Final configuration is done by adjusting the [www.conf](conf/www.conf) file.

## WordPress Command Line Interface
WP-CLI (WordPress Command Line Interface) is a command-line tool for managing WordPress installations.
It provides a [set of commands](https://developer.wordpress.org/cli/commands/) for performing common tasks such as installing WordPress, managing plugins and themes, importing/exporting content, and performing database operations.

During the [entrypoint script](tools/wordpress_setup.sh) wp-cli is used to [download WordPress](tools/wordpress_setup.sh#L67), [create the wp-config.php](tools/wordpress_setup.sh#L76), [adjusting the MariaDB to the more secure environment](tools/wordpress_setup.sh#L89), [install WordPress](tools/wordpress_setup.sh#L96) and [create a new user](tools/wordpress_setup.sh#L110)

## Configuration File
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
			<td rowspan=2><a href="conf/www.conf" target="_blank">www.conf</a></td>
			<td rowspan=2>A configuration file used by PHP-FPM to manage the behavior of PHP processes.</td>
			<td>Set to listen to <a href="conf/www.conf#L37" target="_blank">port 9000</a>.</td>
		</tr>
		<tr><td><a href="conf/www.conf#L408" target="_blank">Pass environment variables to PHP's environment</a>, in order for <a href="https://developer.wordpress.org/apis/wp-config-php/" target="_blank">wp-config.php</a> to access it with <a href="tools/wordpress_setup.sh#L89" target="_blank">getenv()</a>.</td></tr>
	</tbody>
</table>

# PHP FastCGI Process Manager
PHP-FPM is an alternative PHP FastCGI implementation with additional features for managing and scaling PHP processes.
It provides improved performance and resource utilization compared to traditional CGI-based PHP setups by maintaining a pool of worker processes to handle PHP requests.
PHP-FPM allows for fine-grained control over process management, including process pools, process priority, and request timeouts, making it well-suited for high-traffic websites and applications.
