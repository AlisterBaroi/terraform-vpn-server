# Wireguard vpn server (checklist)
# 1. ec2-micro (spot VM, with firewall rule specific tag),
# 2. Container image OS,
# 3. Standard persistent disk (cheapest),
# 4. Promote VMs dynamic IP to static IP,
# 5. Firewall rule to 0.0.0.0/0 (with VM specific tag),
# 6. install wireguard vpn server, (manual process)
# 7. Create 5-10 clients (2 for each person, pc & mobile), (manual process)
# 8. Cost $4 per month (for everyone altogether).

# Creating static external IP address for VPN Server to use
resource "google_compute_address" "wireguard-vpn-server-ip" {
  name = "vpn-static-ip-address"
  description  = "Static external IP address for WireGuard VPN server"
  region       = var.selected_region                                            # Zurich, Switzerland (Low C02)
}

# 1. Creating VM instance for the VPN Server (with firewall rule specific tag)
resource "google_compute_instance" "wireguard-vpn-server" {
  name         = "wireguard-vpn-server"
  description  = "VM server for wireguard VPN"
  machine_type = var.vm_machine_type
  zone         = var.selected_zone                                              # Zurich, Switzerland (Low C02)
  deletion_protection = true
  tags = [var.network_tag]                                                      # ["http-server", "https-server", "lb-health-check"]
  #   allow_stopping_for_update = true                                          # default: commented out, uncommend on second run/update

  
  boot_disk {
    auto_delete = true
    initialize_params {
      # 2. Setting container image OS,
      image = "cos-cloud/cos-109-lts"                                           # Container Optimized OS
      # 3. Setting standard persistent disk,
      type = "pd-standard"                                                      # Balanced/Extreme/SSD/Standard persistent disk (standard is cheapest) 
      size = "10"                                                               # Disk size (10 GB)
    }
  }

  # 4. Promote VMs dynamic IP to static IP,
  network_interface {
    network = "default"
    # Attach the static external IP to the instance
    access_config { 
      nat_ip       = google_compute_address.wireguard-vpn-server-ip.address     # External static IP, if reserved already
      network_tier = "PREMIUM"
    }
  }

#   metadata_startup_script = "echo hi > /test.txt"
#   metadata = {
#     startup-script = var.startup_script
#   }

scheduling {
    provisioning_model  = "SPOT"                                                # SPOT or STANDARD (SPOT is very cheap, but can have downtime)
    automatic_restart   = false                                                 # false if SPOT
    preemptible         = true                                                  # true if SPOT
    on_host_maintenance = "TERMINATE"
  }
}

# 5. Creaating firewall rule to 0.0.0.0/0 (with VM specific tag)
resource "google_compute_firewall" "vpn-server-firewall" {
  name          = "vpn-server-firewall"
  network       = "default"
  source_ranges = ["0.0.0.0/0"]                                                 # Source IPv4 range
  target_tags   = [var.network_tag]
#   allow {
#     protocol = "tcp"
#     ports    = ["51820"]
#   }
  allow {
    protocol = "udp"
    ports    = [var.allowed_port]                                               # Allowed protocol port
  }
  
}


