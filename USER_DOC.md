# User Documentation

Guide for using and managing the Inception infastructure.

## Services

The project provides 3 services:

**WordPress Website**
- Main Page at 'https://<your_intra_username>.42.fr'
- Two users: admin and a regular user
- All content is stored in MariaDB

**MariaDB Database**
- MySQL compatible database
- Not accessible from outside the Docker Network

**NGINX Web Server**
- Handles HTTPS on port 443
- SSL/TLS encryption with self-signed certificate
- Routes traffic to WordPress

## Start Everything
- Head to project's root directory: cd inception
'make' - builds and runs all containers

## Stop Without Removing Data
- 'make down' - Stops containers but does not delete data

## Stop and Remove Data
- 'make fclean' - Stops all containers and removes all data

## Check Status
'docker-compose ps' - Should show all 3 containers with "Up" status.

## Accessing the Website
Go to: 'https://<your_intra_username>.42.fr'
You'll see a certificate warning - click "Advanced" -> "Proceed". This happens because the certificate is self-signed.

## Admin Panek

Login at: 'https://<your_intra_username>.42.fr/wp-admin'

Use the credentials from your '.env' file.

## Managing Credentials

All credentials are inside the '.env' file at teh project root.

### How to change credentials
1. Stop services and remove old data: 'make fclean'
2. Edit '.env'
3. Restart: 'make'

## How to Check Services:

#All containers running?
docker-compose ps

# NGINX responding?
curl -k https://<your_intra_username>.42.fr

# View Logs
docker-compose logs

**Test NGINX**
# Should fail (port 80 not open)
curl http://<your_intra_username>.42.fr

# Should Succeed (Port 443 with SSL)
curl https://<your_intra_username>.42.fr

**Test MariaDB**
docker exec -it mariadb -u root -p, Enter your 'MYSQL_PASSWORD'

## Data Location
- '~/data/wordpress/' # Website files
- '~/data/mariadb/ # Database
