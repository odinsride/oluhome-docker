# oluhome

This repository contains the docker-compose and backup configurations to run oluhome self-hosted services

## Services

* SWAG (Reverse Proxy)
* Vaultwarden (Password Manager)
* Syncthing (File Syncing Service)
* Watchtower (Docker container base image update automation)
* Gitea (Git repository hosting)
* Drone CI (CI/CD Automation)
* Nginx (Target for Docs build)
* Uptime Kuma (Service Status)
* Flame (Dashboard)

## Dependencies

* Built for openSUSE Leap 15.3
  - Can be adjusted for other Distros, primarily by configuring the proper default user groups for directories and systemd service(s)
* Docker
  - `Docker version 20.10.9-ce, build 79ea9d308018`
* Docker Compose
  - `docker-compose version 1.25.1, build a82fef0`
* sqlite3 (cli used for backing up vaultwarden)
* curl
* [Backblaze B2 CLI Tool](https://www.backblaze.com/b2/docs/quick_command_line.html) (Provided in `lib/vendor`)

## Setup

1. Clone Repository
2. Configure `.env` file with appropriate settings, example provided
3. For Vaultwarden, set `ENABLE_SIGNUPS=true` in `docker-compose.yml` in order to create initial user
4. Start containers / Stop containers (to generate config folders)
5. Configure SWAG dns verification service (Cloudflare API key)
6. Configure SWAG proxy services (examples provided)
7. Symlink systemd services/timers:

```
sudo ln -s ~/docker/systemd/oluhome-backup.service /etc/systemd/system/oluhome-backup.service
sudo ln -s ~/docker/systemd/oluhome-backup.timer /etc/systemd/system/oluhome-backup.timer
```

8. Enable and start the oluhome-backup systemd timer:

```
sudo systemctl enable oluhome-backup.timer
sudo systemctl start oluhome-backup.timer
```
9. Start containers with `docker-compose up -d`
10. (optional) After creating a user for vaultwarden, bring containers down and set `ENABLE_SIGNUPS=false`
11. Gitea Setup **(Important!)**:
  * Create a `git` user on the host and generate SSH Keys
  * SSH passthrough configuration (see the following guides):
    - [SSH Container Passthrough](https://docs.gitea.io/en-us/install-with-docker/#ssh-container-passthrough) - Official Gitea Docs
    - [Gitea in Docker Container and Sharing SSH with Host](https://blog.sakuragawa.moe/gitea-in-docker-container-and-sharing-ssh-with-host/) - Sakuragawa Asaba
  * Create an admin user from the Gitea setup page
12. Drone CI Setup:
  * Navigate to (https://drone.example.com) and login, test syncing repos to ensure it connects to Gitea.