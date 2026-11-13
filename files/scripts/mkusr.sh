#!/usr/bin/env bash
set -euo pipefail

# Create the user and set password
useradd -m -G wheel -s /bin/bash strata
echo "strata:password123" | chpasswd

# Enable the display manager
systemctl enable sddm