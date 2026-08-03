# 🚀 Complete Installation Guide — Hermes + Firecrawl + Caddy (HTTPS + Authentication)

This guide walks you through installing a complete **Hermes Agent** stack with:

* ✅ Hermes Agent
* ✅ Hermes Dashboard
* ✅ Caddy (automatic HTTPS)
* ✅ Basic Authentication
* ✅ OpenRouter integration
* ✅ Proper reverse proxy configuration
* ✅ Fix for the **"Invalid Host header"** error

---

# 1. Connect via SSH (after a server reboot)

If the server has been reinstalled or rebooted and the SSH host key has changed:

```bash
ssh-keygen -f ~/.ssh/known_hosts -R 51.254.138.196
ssh ubuntu@51.254.138.196
```

---

# 2. Update the Operating System

```bash
sudo apt update
sudo apt full-upgrade -y
sudo reboot
```

Reconnect to the server:

```bash
ssh ubuntu@51.254.138.196
```

---

# 3. Install Base Dependencies

Install the required packages:

```bash
sudo apt update

sudo apt install -y \
curl \
git \
build-essential \
python3 \
python3-venv \
python3-pip \
caddy \
openjdk-25-jre-headless3\
micro
```

JAVA is required for some tools, but optional if only Hermes Dashboard.

### Install uv

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc
```

---

# 4. Install NVM and Node.js 22 LTS

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc

nvm install 22
nvm use 22

node -v
npm -v
```

---

# 5. Install Docker and Docker Compose

```bash
sudo apt install -y docker.io docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker ubuntu
```

Reconnect so the Docker group membership takes effect:

```bash
exit
ssh ubuntu@51.254.138.196
```

Verify Docker is working:

```bash
docker ps
```

---

# 7. Install & Configure LM Studio CLI (local testing mode)

https://hermes-agent.nousresearch.com/docs/integrations/providers#lm-studio--desktop-app-with-local-models

```bash
sudo apt install curl wget git unzip -y
mkdir -p ~/tmp
curl -fsSL https://lmstudio.ai/install.sh -o install.sh
TMPDIR=$HOME/tmp bash install.sh
rm -f ~/install.sh
rm -rf ~/tmp
sudo rm -rf /tmp/tmp.*

echo 'export PATH="$HOME/.lmstudio/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

micro /home/ubuntu/start-lmstudio.sh
```

'''bash
#!/bin/bash

/home/ubuntu/.lmstudio/bin/lms server start \
  --port 1234 \
  --bind 127.0.0.1

sleep 5

/home/ubuntu/.lmstudio/bin/lms load qwen/qwen3.5-4b \
  --context-length 65536
'''


```bash
chmod +x /home/ubuntu/start-lmstudio.sh
sudo micro /etc/systemd/system/lmstudio.service
```




```ini
[Unit]
Description=LM Studio Server
After=network.target

[Service]
Type=oneshot
User=ubuntu
WorkingDirectory=/home/ubuntu
Environment=HOME=/home/ubuntu

ExecStart=/home/ubuntu/start-lmstudio.sh

RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

```
sudo systemctl daemon-reload
sudo systemctl enable lmstudio
sudo systemctl start lmstudio
sudo systemctl status lmstudio
```

high charge (pic rescue)
```
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```
---

# 7. Install Hermes Agent

```bash
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
source ~/.bashrc

hermes --version
hermes doctor
```

---

# 8. Configure Hermes (OpenRouter)

Run the setup wizard:

```bash
hermes setup
```

Choose:

* **Provider:** OpenRouter
* **API Key:** Your OpenRouter API key
* **Model:** `openrouter/nvidia/nemotron-3-super-120b-a12b:free`

* **Provider:** LMStudio
* **Model:** `qwen/qwen3.5-4b`


---

# 9. Configure tools (Optional TODO)

```
VERSION=$(curl -Ls -o /dev/null -w %{url_effective} \
  https://github.com/AsamK/signal-cli/releases/latest | sed 's/^.*\/v//')
curl -L -O "https://github.com/AsamK/signal-cli/releases/download/v${VERSION}/signal-cli-${VERSION}.tar.gz"
sudo tar xf "signal-cli-${VERSION}.tar.gz" -C /opt
sudo ln -sf "/opt/signal-cli-${VERSION}/bin/signal-cli" /usr/local/bin/
```

https://hermes-agent.nousresearch.com/docs/user-guide/messaging/signal

---

# 10. Install the Hermes Dashboard

```bash
cd ~/.hermes/hermes-agent
uv pip install -e ".[web,pty]"
```

---

# 11. Build the Hermes Dashboard

This step is **required** before running the dashboard.

```bash
cd ~/.hermes/hermes-agent/web
npm install
npm run build
```

Verify that the following directory exists:

```
hermes_cli/web_dist/
```

---

# 12. Create the Hermes Systemd Service

Create the service file:

```bash
sudo micro /etc/systemd/system/hermes.service
```

Paste the following configuration:

```ini
[Unit]
Description=Hermes Agent Dashboard
After=network-online.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu
Environment=HOME=/home/ubuntu

ExecStart=/home/ubuntu/.local/bin/hermes dashboard \
    --host 127.0.0.1 \
    --port 9119 \
    --tui \
    --no-open

Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

Enable and start the service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable hermes
sudo systemctl start hermes

systemctl status hermes
```

---

# 13. Generate a Password Hash for Basic Authentication

Generate a bcrypt password hash:

```bash
caddy hash-password --plaintext 'YOUR_PASSWORD'
```

Copy the generated hash (`$2a$...`) for use in the Caddy configuration.

---

# 14. Configure Caddy (HTTPS + Reverse Proxy + Authentication)

Create or edit the Caddy configuration:

```bash
sudo micro /etc/caddy/Caddyfile
```

Use the following configuration:

```caddy
thearchitect.dev {
    encode gzip

    basicauth {
        fabien YOUR_BCRYPT_HASH
    }

    reverse_proxy 127.0.0.1:9119 {
        header_up Host 127.0.0.1
        header_up Origin http://127.0.0.1:9119
        header_up X-Forwarded-Host {host}
        header_up X-Forwarded-Proto {scheme}
    }
    header {
        Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
        X-Content-Type-Options "nosniff"
        X-Frame-Options "SAMEORIGIN"
        Referrer-Policy "no-referrer"
    }
}
```

## Important

The following directive is **mandatory**:

```caddy
header_up Host 127.0.0.1
```

Without it, Hermes will reject incoming requests and display:

```
Invalid Host header
```

Restart Caddy:

```bash
sudo systemctl restart caddy
```

---

# 15. Configure the Firewall

```bash
sudo ufw allow OpenSSH
sudo ufw allow 80
sudo ufw allow 443
sudo ufw --force enable
```

---

# 16. Final Verification

## Firecrawl

```bash
docker ps
curl http://localhost:3002/health
```

Expected response:

```json
{"status":"ok"}
```

---

## Hermes Dashboard

```bash
systemctl status hermes
ss -tlnp | grep 9119
```

---

## Validate the Caddy Configuration

```bash
sudo caddy validate --config /etc/caddy/Caddyfile
```

---

# 17. Access the Dashboard

Open your browser and navigate to:

```
https://thearchitect.dev
```

You should see:

* Basic Authentication prompt
* Hermes Dashboard
* Automatic HTTPS (Let's Encrypt)
* No **"Invalid Host header"** error
* Firecrawl fully integrated and operational

---

# Troubleshooting

## Firecrawl is not responding

Check the container status:

```bash
docker ps
docker logs firecrawl
```

Restart if necessary:

```bash
docker compose restart
```

---

## Hermes service is not running

Inspect the logs:

```bash
journalctl -u hermes -f
```

Restart the service:

```bash
sudo systemctl restart hermes
```

---

## Caddy configuration errors

Validate the configuration:

```bash
sudo caddy validate --config /etc/caddy/Caddyfile
```

Reload Caddy:

```bash
sudo systemctl reload caddy
```

---

## "Invalid Host header"

Ensure your Caddy configuration includes:

```caddy
reverse_proxy 127.0.0.1:9119 {
    header_up Host 127.0.0.1
}
```

This directive is required for the Hermes Dashboard to accept proxied requests.

---

# Architecture Overview

```
Internet
     │
     ▼
HTTPS (443)
     │
     ▼
Caddy
     │
     ▼
Hermes Dashboard (127.0.0.1:9119)
     │
     ├──────────────► OpenRouter
     │
     └──────────────► Firecrawl (Docker)
                         │
                         ▼
                 localhost:3002
```

The resulting deployment provides a secure, production-ready AI agent environment with automatic HTTPS, authentication, a web dashboard, integrated web crawling, and a clean reverse proxy configuration.
