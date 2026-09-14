#!/usr/bin/env bash
set -euo pipefail

echo "===> Applying SRE Linux Kernel Optimizations..."

# 1. Enable Google BBR Congestion Control & FQ
echo "net.core.default_qdisc=fq" | sudo tee -a /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" | sudo tee -a /etc/sysctl.conf

# 2. Adjust Swappiness & Cache pressure for 24/7 Server
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
echo "vm.vfs_cache_pressure=50" | sudo tee -a /etc/sysctl.conf

# 3. Increase File Descriptors & Socket connection limits
echo "fs.file-max=2097152" | sudo tee -a /etc/sysctl.conf
echo "net.core.somaxconn=4096" | sudo tee -a /etc/sysctl.conf

# Apply changes
sudo sysctl -p

echo "===> Kernel optimizations applied successfully!"
