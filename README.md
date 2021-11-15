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
* curl
* [Backblaze B2 CLI Tool](https://www.backblaze.com/b2/docs/quick_command_line.html)

## Setup

1. Clone Repository
2. Configure `.env` file
3. Start containers / Stop containers (to generate config folders)
4. Configure SWAG dns verification service (Cloudflare API key)
5. Configure SWAG proxy services (examples provided)
6. Symlink systemd services/timers:

```
sudo ln -s ~/docker/systemd/oluhome-backup.service /etc/systemd/system/oluhome-backup.service
sudo ln -s ~/docker/systemd/oluhome-backup.timer /etc/systemd/system/oluhome-backup.timer
```

7. Enable and start the oluhome-backup systemd timer:

```
sudo systemctl enable oluhome-backup.timer
sudo systemctl start oluhome-backup.timer
```

8. For Vaultwarden, set `ENABLE_SIGNUPS=true` in `docker-compose.yml` in order to create initial user
9. Start containers with `docker-compose up -d`
10. (optional) After creating a user for vaultwarden, bring containers down and set `ENABLE_SIGNUPS=false`