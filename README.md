# secure-my-vps

Script to harden a freshly deployed Debian-based VPS.

## What it does

1. Disables password authentication and root login over SSH
2. Installs and configures UFW, denying all inbound traffic by default
3. Enables Fail2ban
4. Joins a Tailscale mesh network
5. Restricts SSH and web access to the Tailscale network only
6. Disables IPv6

## Requirements

- SSH key authentication must be working before running (or you will lock yourself out)
- Debian-based distribution
- A Tailscale account

## Usage

```bash
wget https://raw.githubusercontent.com/benbelo/secure-my-vps/main/secure-my-vps.sh
chmod +x secure-my-vps.sh
sudo ./secure-my-vps.sh
```
