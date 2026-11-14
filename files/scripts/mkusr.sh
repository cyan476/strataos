#!/usr/bin/env bash
set -euo pipefail

# 1. Create user without mail spool warning
useradd -m -G wheel -s /bin/bash -K MAIL_DIR=/dev/null strata

# 2. Set pre-hashed password to bypass PAM pwquality checks
HASH=$(openssl passwd -6 "strata")
echo "strata:${HASH}" | chpasswd -e

# 3. Enable SDDM directly via its unit file on disk
if [ -f /usr/lib/systemd/system/sddm.service ]; then
    systemctl disable plasma-login-manager.service 2>/dev/null || true
    systemctl enable sddm.service
elif [ -f /usr/lib/systemd/system/plasma-login-manager.service ]; then
    systemctl enable plasma-login-manager.service
else
    echo "Error: No display manager unit file found in /usr/lib/systemd/system/"
    ls -la /usr/lib/systemd/system/*display* /usr/lib/systemd/system/*sddm* /usr/lib/systemd/system/*plasma* 2>/dev/null || true
    exit 1
fi