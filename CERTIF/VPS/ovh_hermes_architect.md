# 🚀 Complete Installation Guide — Hermes + Caddy (HTTPS + Authentication)

This guide walks you through installing a complete **Hermes Agent** stack with:

* ✅ Hermes Agent
* ✅ Hermes Dashboard
* ✅ Caddy (automatic HTTPS)
* ✅ Basic Authentication
* ✅ OpenRouter integration
* ✅ Proper reverse proxy configuration
* ✅ Fix for the **"Invalid Host header"** error

---
## Prerequisite: Configure DNS Records for LLM UI

Before configuring Caddy, create the required DNS records for your domain.

If your server IP is:

```text
51.254.138.196
```

Create the following A records in your DNS provider (OVH, Cloudflare, Gandi, etc.):

```text
Type    Name      Value
A       @         51.254.138.196 --> by default --> hermes
A       llm       51.254.138.196
```

This creates:

```text
https://thearchitect.dev --> hermes
https://llm.thearchitect.dev
```

### OVH Example

1. Log in to OVH Manager
2. Open **Web Cloud**
3. Select your domain
4. Open **DNS Zone**
5. Click **Add an entry**
6. Select **A Record**
7. Create:

```text
Name: llm
Target: 51.254.138.196
```

and:

```text
Name: hermes
Target: 51.254.138.196
```

## *Bonus : Swap for llm in VPS*

```
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

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
openjdk-25-jre-headless \
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

# 7. Install llama.cpp

```bash
sudo apt update
sudo apt install -y curl jq tar

for TAG in $(curl -s https://api.github.com/repos/ggml-org/llama.cpp/releases \
  | jq -r '.[0:20][] | .tag_name'); do

  URL="https://github.com/ggml-org/llama.cpp/releases/download/${TAG}/llama-${TAG}-bin-ubuntu-x64.tar.gz"

  echo "Trying $TAG"

  if curl -fsL "$URL" -o llama.tar.gz; then
    if tar -tzf llama.tar.gz >/dev/null 2>&1; then
      echo "Using $TAG"

      sudo tar -xzf llama.tar.gz \
        -C /usr/local/bin \
        --strip-components=1

      rm -f llama.tar.gz
      break
    fi
  fi

  rm -f llama.tar.gz
done
```

Verify:

```bash
llama-server --version
```

Create the startup script:

```bash
micro ~/start-llama.sh
```

```bash
#!/bin/bash

llama-server \
  -hf unsloth/gemma-4-E2B-it-GGUF:Q4_K_M \
  --host 127.0.0.1 \
  --port 1234 \
  --context-shift \
  --swa-full \
  --jinja
```

```bash
chmod +x ~/start-llama.sh
```

Create the service:

```bash
sudo micro /etc/systemd/system/llama-server.service
```

```ini
[Unit]
Description=llama.cpp Server

[Service]
User=ubuntu
ExecStart=/home/ubuntu/start-llama.sh
Restart=always

[Install]
WantedBy=multi-user.target
```

Start it:

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now llama-server
sudo systemctl status llama-server
```

Test:

```bash
curl http://127.0.0.1:1234/v1/models
```

Hermes:

```text
Provider: OpenAI Compatible
Base URL: http://127.0.0.1:1234/v1
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

* **Provider:** custom
* **Model:** `qwen/qwen3.5-4b` 


---

# 9. Configure tools (Optional TODO)


https://hermes-agent.nousresearch.com/docs/user-guide/messaging/signal


```bash
sudo micro /etc/systemd/system/signal-cli.service
```

```ini
[Unit]
Description=Signal-CLI Daemon Service
After=network.target

[Service]
Type=simple
User=ubuntu
ExecStart=/usr/local/bin/signal-cli --account +1234567890 daemon --http 127.0.0.1:8080
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl start signal-cli
sudo systemctl enable signal-cli
```


---

# 10. Install the Hermes Dashboard

```bash
cd ~/.hermes/hermes-agent
uv sync
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

ExecStart=/bin/bash -lc '/home/ubuntu/.local/bin/hermes dashboard --host 127.0.0.1 --port 9119 --tui --no-open'

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

llm.thearchitect.dev {
    encode gzip

    basicauth {
        fabien YOUR_BCRYPT_HASH
    }

    reverse_proxy 127.0.0.1:1234
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

---

# Troubleshooting

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
                  ┌────────────┐
                  │    Caddy    │
                  │  HTTPS 443  │
                  └────────────┘
                         │
                         ▼
              Reverse Proxy + Auth
                         │
                         ▼
        ┌────────────────────────────────┐
        │   Hermes Dashboard (localhost) │
        │        127.0.0.1:9119          │
        └────────────────────────────────┘
                         │
         ┌───────────────┴────────────────┐
         │                                  │
         ▼                                  ▼
   OpenRouter API                    LM Studio (local)
 (external provider)                 127.0.0.1:1234

```

The resulting deployment provides a secure, production-ready AI agent environment with automatic HTTPS, authentication, a web dashboard, integrated web crawling, and a clean reverse proxy configuration.
