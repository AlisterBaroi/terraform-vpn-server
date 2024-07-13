
# Startup script to run WireGuard on Docker (PEERS = number of clients)
# variable "startup_script" {
#  description = "Startup script for VM to launch at startup"
#  type        = string
#  default     = <<EOT
#  docker run -d \
#   --name=wireguard \
#   --cap-add=NET_ADMIN \
#   -e PUID=1000 \
#   -e PGID=1000 \
#   -e TZ=Etc/UTC \
#   -e PEERS=1 \
#   -p 51820:51820/udp \
#   -v /var/config:/config \
#   --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
#   --restart unless-stopped \
#   lscr.io/linuxserver/wireguard:latest
#  EOT
# }

variable "network_tag" {
 description = "Network tag to let specific firewall rule to impliment on specifc VM"
 type        = string
 default     = "vpn-server"                                                                    # Custom Network Tag, other system tags: ["http-server", "https-server", "lb-health-check"]
}

variable "selected_region" {
 description = "Region of IP reservtion"
 type        = string
 default     = "europe-west6"                                                                   # Region of deployment, defaullt set to europe-west6 (Zurich, Switzerland - Low C02)
}

variable "selected_zone" {
 description = "Zone of VM deployment"
 type        = string
 default     = "europe-west6-a"                                                                 # Zone of deployment, defaullt set to europe-west6-a (Zurich, Switzerland - Low C02)
}

variable "vm_machine_type" {
 description = "VM type"
 type        = string
 default     = "e2-micro"                                                                       # VM type to deploy
}

variable "del_protection" {
 description = "Deletion Protectionn for VM"
 type        = string
 default     = true                                                                             # Set if VM is deleton protected
}

variable "vm_os" {
 description = "M's OS"
 type        = string
 default     = "cos-cloud/cos-109-lts"                                                          # Set OS image for VM, default set to cos-cloud/cos-109-lts (Container Optimized OS)
}

variable "dsk_type" {
 description = "Set VM's Boot Disk Type"
 type        = string
 default     = "pd-standard"                                                                    # Balanced/Extreme/SSD/Standard persistent disk (standard is cheapest), default set to pd-standard.  
}

variable "dsk_size" {
 description = "Boot Disk size"
 type        = string
 default     = "10"                                                                             # Disk size, default set to 10 (10 GB)
}
                                                       
variable "allowed_port" {
 description = "Firewall port"
 type        = string
 default     = "51820"                                                                          # Default port
}
