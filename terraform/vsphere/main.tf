#===============================================================================
# vSphere Modules
#===============================================================================


# make multiple vms

module "linux" {
  count  = 2
  source = "../modules/vsphere_vm"
  # vm_name         = "docker-${count.index+1}"
  vm_name         = "vm-${count.index + 1}"
  vm_template     = "deb-x12-template"
  vsphere_cluster = var.vsphere_cluster
  vm_datastore    = "data-store"
  network_spec = {
    network_id = "VM Network"
  }
  spec = {
    os_type   = "linux"
    cpu       = 2
    memory    = 5120
    disk_size = 16
    additional_disks = [
      {
        size = 25
      }
    ]
  }
}

