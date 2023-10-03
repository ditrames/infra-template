
packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

locals {
  enable_ssh = {
    "/install.sh" = templatefile("${abspath(path.root)}/config/install.sh", {
      username = "arch"
      password = "arch"
    })
    "/bootstrap-system.sh" = templatefile("${abspath(path.root)}/config/bootstrap-system.sh", {
      username     = var.guest_username
      password     = var.guest_password
    })

  }
}

source "proxmox-iso" "arch-deployment" {
  boot_command = [
		"<enter><wait10><wait10><wait10>",
    // "ip addr add ${var.vm_ip_addr} dev ens18<enter><wait5>",
    // "ip link set ens18 up<enter><wait5>",
    // "ip route add 0.0.0.0/0 via 10.0.5.1<enter><wait5>",
		"/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter><wait1>",
		"/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/bootstrap-system.sh<enter><wait1>",
    "chmod +x *.sh<enter><wait1>",
		"/usr/bin/bash ./install.sh<enter><wait10>"
    ]
  boot_wait    = "10s"
  scsi_controller = "virtio-scsi-single"

  bios = "ovmf"
  machine = "q35"
  efi_config {
    efi_storage_pool  = "local-lvm"
    efi_type          = "4m"
  }

  disks {
    disk_size         = var.disk_size
    storage_pool      = var.disk_pool
    type              = "scsi"
  }

  http_content = local.enable_ssh
  insecure_skip_tls_verify = true

	iso_storage_pool = var.iso_storage_pool
  iso_url 								 = var.iso_url
	iso_checksum		         = "${var.iso_checksum_type}:${var.iso_checksum}"

	dynamic "network_adapters" {
    for_each = var.network_adaptors
    content {
			bridge = network_adapters.value.adapter
			model  = network_adapters.value.driver
			vlan_tag 	 = network_adapters.value.vlan
		}
	}

  memory = 2000

  node                 = var.proxmox_node
  token             = var.proxmox_token
  proxmox_url          = "https://${var.proxmox_url}/api2/json"
  username             = var.proxmox_username

  ssh_password         = "arch"
  ssh_timeout          = var.ssh_timeout
  ssh_username         = "arch"

  template_description = "arch templated made on: ${timestamp()}"
  template_name        = "arch-template"
  unmount_iso          = true
}

build {
  sources = ["source.proxmox-iso.arch-deployment"]

}
