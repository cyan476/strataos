#!/usr/bin/env bash
set -euo pipefail

# 1. Create user without trying to create a missing mail spool directory
useradd -m -G wheel -s /bin/bash -K MAIL_DIR=/dev/null strata

# 2. Set password using a pre-generated SHA-512 hash to bypass PAM dictionary checks
HASH=$(openssl passwd -6 "strata")
echo "strata:${HASH}" | chpasswd -e

# 3. Enable whichever Plasma display manager is installed in this Fedora base
if systemctl list-unit-files | grep -q "^plasma-login-manager.service"; then
    systemctl enable plasma-login-manager.service
elif systemctl list-unit-files | grep -q "^sddm.service"; then
    systemctl enable sddm.service
else
    echo "Warning: Neither plasma-login-manager nor sddm found!"
    exit 1
fi