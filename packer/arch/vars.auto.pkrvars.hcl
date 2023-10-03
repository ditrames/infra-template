iso_url = "http://www.mirrorservice.org/sites/ftp.archlinux.org/iso/2023.09.01/archlinux-x86_64.iso"
iso_checksum = "0d71c9bc56af75c07e89cd41eaa5570ac914677ad6bc8e84935dc720ce58f960"
iso_checksum_type = "sha256"
guest_username = "ditrames"
proxmox_url = "10.0.1.30:8006"
proxmox_node = "pve-workstation"
disk_pool = "local-lvm"
iso_storage_pool = "local"
disk_size = "20G"
vm_ip_addr = "10.0.5.30/24"
network_adaptors = [
    {
        driver = "virtio",
        adapter = "vmbr0",
        vlan = 70
    }
]