FROM ubuntu:trusty

# MySQL Configuration variables
ENV db_name project
ENV db_user admin
ENV db_password admin
ENV db_host localhost

# PHP Configuration variables
ENV php_timezone UTC
ENV php_upload_max_size 20M
ENV php_post_max_size 20M
ENV php_memory_limit 256M

# Update repositories
RUN apt-get update

# Install nano
RUN apt-get -y install nano

# Install curl
RUN apt-get -y install curl

# Install Apache
RUN apt-get -y install apache2
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Install MySQL
RUN apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql

# Install PHP
RUN apt-get -y install php5 libapache2-mod-php5 php5-mcrypt php5-cli php5-gd php5-imagick php5-curl php5-intl

# PHP Configuration
ADD php_config.sh /php_config.sh
RUN chmod 755 /php_config.sh
RUN ./php_config.sh ${php_timezone} ${php_upload_max_size} ${php_post_max_size} ${php_memory_limit}

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Configure Apache virtual host
RUN mkdir /var/www/project
RUN mkdir /var/www/project/web
COPY project.conf /etc/apache2/sites-available/project.conf
RUN a2dissite 000-default.conf
RUN a2ensite project.conf
RUN a2enmod rewrite

# Create db and user with permissions on db
RUN service mysql start
ADD mysql_config.sh /mysql_config.sh
RUN chmod 755 /mysql_config.sh
RUN ./mysql_config.sh ${db_name} ${db_user} ${db_password} ${db_host}

# Expose container ports
EXPOSE 80 3306

# Start Apache, MySQL and bash on docker run
ENTRYPOINT service apache2 restart && service mysql restart && bash
