# 🛸 Homelab Infrastructure (Infrastructure as Code)

> **"In SRE culture, we treat servers as Cattle, not Pets."**

This repository contains the complete Infrastructure as Code (IaC), Docker Compose definitions, kernel tuning scripts, and monitoring configurations for Matheus Dias's distributed homelab.

---

## 🏗️ Hardware Architecture & Cluster Topology

* **Dell OptiPlex 7050 Micro (Master Node - x86_64):**
  * Intel Core i5-7500T (4C/4T, 35W TDP, Intel QuickSync Video)
  * 16 GB DDR4 SODIMM
  * 128 GB M.2 NVMe SSD (OS + Docker + Databases) + 1 TB 2.5" SATA (Media/Immich)
  * Services: `tesouro-backend-go`, `immich`, `postgres`, `redis`
* **Raspberry Pi 4 (Witness & Monitoring Node - ARM64):**
  * BCM2711 Quad-Core @ 1.5 GHz
  * Services: `prometheus`, `grafana`, `uptime-kuma`, `cloudflared-fallback`
* **Edge Gateway:** High-throughput WAN gateway in Bypass Mode.
* **Network Overlay:** Zero Trust via Cloudflare Tunnels and Tailscale Mesh (WireGuard P2P).

---

## 📁 Repository Structure

```text
homelab-infrastructure/
├── docker/
│   ├── docker-compose.apps.yml       # Immich, Postgres, Go APIs
│   ├── docker-compose.monitoring.yml # Prometheus, Grafana, Node Exporter
│   └── docker-compose.ingress.yml    # Cloudflare Tunnels (cloudflared)
├── scripts/
│   ├── setup-kernel-tuning.sh        # Google BBR, swappiness, I/O schedulers
│   └── backup-database-r2.sh         # Automated encrypted DB backups to Cloudflare R2
├── configs/
│   ├── prometheus/prometheus.yml     # Scrape targets for the 4 Golden Signals
│   └── grafana/                      # Dashboards & data source provisioning
└── README.md
```

---

## ⚡ Quickstart: Rebuilding a Node from Scratch

If a disk fails or you install a fresh Debian 12 Minimal image:

```bash
# 1. Clone this repository
git clone https://github.com/matheusdias/homelab-infrastructure.git
cd homelab-infrastructure

# 2. Apply SRE Kernel Tuning (BBR, swappiness)
sudo bash scripts/setup-kernel-tuning.sh

# 3. Start services
docker compose -f docker/docker-compose.apps.yml up -d
docker compose -f docker/docker-compose.monitoring.yml up -d
docker compose -f docker/docker-compose.ingress.yml up -d
```
