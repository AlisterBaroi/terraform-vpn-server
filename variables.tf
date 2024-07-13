
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
 default     = "vpn-server"
}

variable "selected_region" {
 description = "Region of IP reservtion"
 type        = string
 default     = "europe-west6"
}

variable "selected_zone" {
 description = "Zone of VM deployment"
 type        = string
 default     = "europe-west6-a"
}

variable "vm_machine_type" {
 description = "VM type"
 type        = string
 default     = "e2-micro"
}

variable "allowed_port" {
 description = "Firewall port"
 type        = string
 default     = "51820"
}
