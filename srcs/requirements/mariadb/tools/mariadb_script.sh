#!/bin/bash

# Read the secrets from the files
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_rootpw)
MYSQL_USER_PASSWORD=$(cat /run/secrets/db_pw)

# check if MariaDB is initialized
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "Initializing MariaDB"
	
	mysqld &

	sleep 5

    echo "Sending commands"
	sleep 5
    # Use Heredoc to execute multiple SQL commands
    mysql --user root << _EOF
-- Set root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

-- Create the database
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- Create the user
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';

-- Grant privileges to the user
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

-- Flush privileges to apply changes
FLUSH PRIVILEGES;
_EOF

	echo "Stopping daemon"
	sleep 5
    # Stop the MariaDB instance after initialization
    mysqladmin --user root --password "${MYSQL_ROOT_PASSWORD}" shutdown
fi

echo "Starting the service"
sleep 5
# Start MariaDB normally
exec mysqld
