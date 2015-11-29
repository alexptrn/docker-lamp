#!/bin/bash

# Configure timezone

sed -i "s/;date.timezone =.*/date.timezone = $1/g" /etc/php5/apache2/php.ini
sed -i "s/;date.timezone =.*/date.timezone = $1/g" /etc/php5/cli/php.ini

# Configure upload max size

sed -i "s/upload_max_filesize =.*/upload_max_filesize = $2/g" /etc/php5/apache2/php.ini
sed -i "s/post_max_size =.*/post_max_size = $3/g" /etc/php5/apache2/php.ini

# Configure memory limit

sed -i "s/memory_limit =.*/memory_limit = $4/g" /etc/php5/apache2/php.ini

rm /php_config.sh
