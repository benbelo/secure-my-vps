#!/bin/bash

# Manifest to secure and protect any Debian-based VMs (not well commented)
# Using tailscale but feel free to use any other VPN solution (wireguard, openvpn)

set -e

# Check if root
if [[ $EUID -ne 0 ]]; then
    echo "Plz run this script as root"
    exit 1
fi

apt update

# SSH
echo "Hardening SSH"
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
cat >> /etc/ssh/sshd_config << 'EOF'
PasswordAuthentication no
PermitRootLogin no
EOF
systemctl reload sshd
echo "SSH secured"
echo ""

# UFW
echo "Setting up UFW"
apt install ufw -y
ufw default deny incoming
ufw default allow outgoing
ufw enable
echo "UFW configured to block incoming packets"
echo ""

# fail2ban
echo "Setting fail2ban"
apt install fail2ban -y
systemctl enable --now fail2ban
echo "fail2ban configured"
echo ""

## Tailscale
read -rp "Paste Tailscale auth command (curl | tailscale up ID): " cmd

if [[ -z "$cmd" ]]; then
    echo "No command provided. Exiting."
    exit 1
fi
eval "$cmd"

## Authorize only SSH via Tailscale net
if tailscale status &>/dev/null; then
    ufw allow from 100.64.0.0/10 to any port 22 proto tcp
    ufw delete allow OpenSSH 2>/dev/null || true
else
    echo "Tailscale is not running. Please debug. UFW rule not applied."
fi

## Authorize Web only via Tailscale net
ufw allow from 100.64.0.0/10 to any port 443 proto tcp
ufw allow from 100.64.0.0/10 to any port 80 proto tcp
echo "UFW Web rules applied"

## Disabling ipv6
sed -i 's/IPV6=yes/IPV6=no/' /etc/default/ufw 2>/dev/null || true
echo "net.ipv6.conf.all.disable_ipv6 = 1" | tee -a /etc/sysctl.conf
sysctl -p && ufw reload
echo "IPV6 disabled"
