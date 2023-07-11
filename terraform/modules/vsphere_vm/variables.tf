

# variable "vsphere_unverified_ssl" {
#   description = "Is the vCenter using a self signed certificate (true/false)"
#   default     = "true"
# }

variable "vsphere_datacenter" {
  description = "vSphere datacenter"
  default     = "{replace dc}"
}

variable "vsphere_cluster" {
  description = "vSphere cluster"
}

#=========================#
# vSphere virtual machine #
#=========================#

variable "vm_datastore" {
  description = "Datastore used for the vSphere virtual machines"
}

variable "vm_template" {
  description = "Template used to create the vSphere virtual machines"
}

variable "vm_name" {
  description = "The name of the vSphere virtual machines and the hostname of the machine"
}

variable "vm_domain" {
  description = "The domain of the vSphere virtual machines and the hostname of the machine"
  default     = "{replace domain}"
}


variable "spec" {
  type = object({
    enable_hv    = optional(bool)
    cpu          = number
    memory       = number
    disk_size    = number
    os_type      = optional(string)
    linked_clone = optional(bool)
    additional_network = optional(list(object({
      network = string
    })))
    additional_disks = optional(list(object({
      size         = number
      datastore_id = optional(string)
      attach_disk  = optional(bool)
    })))
  })
}

variable "network_spec" {
  type = object({
    network_id      = optional(string)
    mac_address     = optional(string)
    static_mac_addr = optional(bool)
  })
}
