#Inception

_This project has been created as part of the 42 curriculum by nsarmada_

## Description

System administration project using Docker to set up a small indastracture with NGINX, WordPress and MariaDB running in separate containers. The goal is to configure and orchestrate multiple services using docker-compose and understand how containers work.

Each service runs within its own container with its own custom Dockerfile. NGINX is exposed to the internet through port 443 and it handles HTTPS traffic with TLS 1.2/1.3. WordPress runs with php-fpm and MariaDB is used to store the database. Each service is isolated, but they all communicate through a bridge network. Data persists across container restarts using Docker volumes mounted to the host filesystem.

The project covers Docker fundamentals, networking, volume management, SSL configuration and service orchestration through docker-compose.

## Setup

1. Clone repository:
git clone <repository-url>

2. Configure Domain:
cd inception
sudo nano /etc/hosts 
#Add 127.0.0.1 <your_intra_username>.42.fr

3. Create .env file with your credentials for admin and one more user:
MYSQL_DATABASE=wordpress
MYSQL_USER=<your_intra_username>
MYSQL_PASSWORD=your_password
MYSQL_ROOT_PASSWORD=your_root_password
DOMAIN_NAME=<your_intra_username>.42.fr

WP_ADMIN_USER=admin_username
WP_ADMIN_PASSWORD=admin_password
WP_ADMIN_EMAIL=admin@42.fr

WP_USER=user_name
WP_USER_PASSWORD=user_password
WP_USER_EMAIL=user_email

## Commands

- `make` - build and start containers
- `make down` - stop containers
- `make fclean` - remove everything including data

## Resources

- [Docker docs](https://docs.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [NGINX configuration](https://nginx.org/en/docs/)
- [WordPress setup](https://developer.wordpress.org/)
- [MariaDB docs](https://mariadb.com/kb/en/)

### AI Usage
- Syntax for NGINX, docker-compose, WordPress and MariaDB configurations
- Debugging
- Acquiring information about all the new subjects in the project.

All code was written and tested by me. 


## Docker Choices

**VMs vs Docker**
Virtual Machines run complete operating systems, which means they are slow and heavy, especially compared to Docker. Docker containers share the host OS kernel, which in turn makes them faster.

**Docker Network vs Host** 
Docker bridge network creates an isolated network where containers communicate by name. Host network would expose everything directly to the host machine (faster but less secure).

**Volumes vs Bind Mounts**
Docker volumes are managed by Docker. Bind mounts link to specific host paths. This project uses volumes configured to bind to `~/data/`, combining both Docker management with accessible host storage.

**Secres vs Environment Variables**
Docker secrets are encrypted and require Swarm mode (production). Environment variables in `.env` are plain text but simpler for development. This project uses `.env` that is of course, never commited to git. This is achieved by adding `.env` to our `.gitignore`.