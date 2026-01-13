#!/bin/bash

sleep 5

if [ ! -f "wp-config.php" ]; then
	#download the actual Wordpress files
	wp core download --allow-root

	wp config create \
		--dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} \
		--dbhost=mariadb \
		--allow-root

		#finish installation
		wp core install \
		--url=${DOMAIN_NAME} \
		--title="Inception" \
		--admin_user=${WP_ADMIN_USER} \
		--admin_password=${WP_ADMIN_PASSWORD} \
		--admin_email=${WP_ADMIN_EMAIL} \
		--skip-email \
		--allow-root
	
	wp user create ${WP_USER} ${WP_USER_EMAIL} --role=author \
	--user_pass=${WP_USER_PASSWORD} --allow-root
	fi

	#start php-fm so the container stays alive
	exec php-fpm7.4 -F