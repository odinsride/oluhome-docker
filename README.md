# oluhome

This repository contains the docker-compose and backup configurations to run oluhome self-hosted services

## Services

* SWAG (Reverse Proxy)
* Vaultwarden (Password Manager)
* Syncthing (File Syncing Service)
* Watchtower (Docker container base image update automation)

## Dependencies

* Docker
* Docker Compose
* sqlite3 (cli used for backing up vaultwarden)

## Setup

1. Clone Repository
2. Configure `.env` file
3. Start containers / Stop containers (to generate config folders)
4. Configure SWAG dns verification service (Cloudflare API key)
5. Configure SWAG proxy services (examples provided)
6. Symlink systemd services/timers
7. For Vaultwarden, set `ENABLE_SIGNUPS=true` in `docker-compose.yml` in order to create initial user
8. Start containers with `docker-compose up -d`
9. (optional) After creating a user for vaultwarden, bring containers down and set `ENABLE_SIGNUPS=false`