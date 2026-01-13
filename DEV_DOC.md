# Developer Documentation

Technical guide for developers working on the Inception project.

## Prerequisites

**System Requirements**
- Docker Engine 20.10+
- Docker Compose 1.29+
- 2GB RAM, 5GB disk space

**Install Docker**

macOS: Download Docker Desktop from `https://www.docker.com/products/docker-desktop`

Linux (Debian/Ubuntu):
sudo apt update
sudo apt intall docker.io docker-compose make
sudo usermod -aG docker $USER

# After this is complete you have to log out and back in

1. Clone the repository
- git clone <repository-url>

2. Enter the repository
- cd inception

3. Create and Populate the `.env` file at project root
- touch .env
#Populate the file with all the necessary variables, you can find an example at `README.md` of this project

4. Configure domain in `/etc/hosts`
- sudo nano /etc/hosts
# Add: 127.0.0.1 <your_intra_username>.42.fr

**Building and Launching**

## Using Makefile

# Build and start all services
make

# Stop containers (keep data)
make down

# Restart
make re

# Stop and remove volumes
make clean

# Complete cleanup (removes ~/data/)
make fclean

## Using Docker Compose

# Build images
docker-compose build

# Start services
docker-compose up

# Start in background
docker-compose up -d

# Stop services
docker-compose down

# Stop and remove volumes
docker-compose down -v

**Managing Containers and Volumes**

## Container Management

# View running containers
docker-compose ps

# View logs
docker-compose logs
docker-compose logs nginx
docker-compose logs -f # follow live

## Volume management

# List volumes
docker volume ls

## Where Data is Stored

# On host machine:
- `~/data/mariadb/` - MariaDB database files
- `~/data/wordpress/` - WordPress website files

# In Containers:
- MariaDB container: `/var/lib/mysql` → `~/data/mariadb/`
- WordPress container: `/var/www/wordpress` → `~/data/wordpress/`
- NGINX container: `/var/www/wordpress` → `~/data/wordpress/`

## How Persistence works

The project uses Docker named voluems configured with bind mounts in `docker-compose.yml`:

volumes:
  db_data:
    driver: local
    driver_opts:
      type: none
      device: ${HOME}/data/mariadb
      o: bind
  wp_data:
    driver: local
    driver_opts:
      type: none
      device: ${HOME}/data/wordpress
      o: bindData persists because:
- Volumes are mounted to host directories (`~/data/`)
- When containers stop, data remains on the host
- When containers restart, they reconnect to the same volumes
- Only `make fclean` removes the data directories