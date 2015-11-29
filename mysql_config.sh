#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

mysql -u root -e "CREATE DATABASE $1 CHARACTER SET utf8 COLLATE utf8_general_ci;";
mysql -u root -e "CREATE USER '$2'@'$4' IDENTIFIED BY '$3';";
mysql -u root -e "GRANT ALL PRIVILEGES ON $1.* TO '$2'@'$4';";

rm /mysql_config.sh
