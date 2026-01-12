#!/bin/bash

# 1. Start the service locally
service mariadb start

# 2. Wait for it to wake up
sleep 5

# 3. Execute the commands using the -e flag
# Create the database
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

# Create the user and set password
mariadb -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

# Grant permissions (Note the spelling of PRIVILEGES)
mariadb -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"

# Set the Root password (very important for the evaluation!)
mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

# Save changes
mariadb -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# 4. Shut down so the Docker ENTRYPOINT can take over in the foreground
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# 5. Run the database in the foreground
exec mysqld_safe