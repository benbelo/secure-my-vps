# Script bash pour rapidement sécuriser un VPS

Petit script pour sécuriser un VPS fraichement déployé.  
Un post Twitter avec des suites de commandes m'a inspiré à en faire un script propre et semi-automatisé.  

## Que fait ce script ?

1. **Renforcement SSH** - Désactiver l'authent par mdp et le root login
2. **UFW** - Installe et configure UFW et Deny l'incoming
3. **Fail2ban (brute-force)** - Active le fail2ban
4. **Tunnel Mesh Tailscale** - Intégration dans ton tunnel Tailscale
5. **SSH et Web via tunnel** - Restriction Web et SSH au réseau Tailscale uniquement
7. **IPv6** - Désactivation de l'IPv6

## Prérequis

Avant d'exécuter ce script, assurez-vous que:

- L'authentification par clé SSH fonctionne correctement (sinon vous serez bloqué de votre serveur).
- Peu importe le Cloud Provider, assurez-vous que la machine soit une distribution Debian-based.
- Vous disposez d'un compte Tailscale (https://tailscale.com).

## Quick start

```bash
# Téléchargez le script
wget https://raw.githubusercontent.com/benbelo/secure-my-vps/main/secure-my-vps.sh

# Rendez le exécutable
chmod +x secure-vps.sh

# Lancez en sudo
sudo ./secure-vps.sh
```
