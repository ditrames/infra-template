#====================#
# vCenter connection #
#====================#

variable "vsphere_vcenter" {
  description = "vCenter server FQDN or IP"
  type        = string
}

variable "vsphere_unverified_ssl" {
  description = "Is the vCenter using a self signed certificate (true/false)"
  type        = string
}

# variable "vsphere_datacenter" {
#   description = "vSphere datacenter"
#   type        = string
# }

variable "vsphere_cluster" {
  description = "vSphere cluster"
  type        = string
}

# #=========================#
# # vSphere virtual machine #
# #=========================#

# variable "vm_datastore" {
#   description = "Datastore used for the vSphere virtual machines"
#   type        = string
# }

# variable "vm_network" {
#   description = "Network used for the vSphere virtual machines"
#   type        = string
# }

# variable "vm_template" {
#   description = "Template used to create the vSphere virtual machines"
#   type        = string
# }

# variable "vm_ip" {
#   description = "Ip used for the vSphere virtual machine"
#   type        = string
# }

# variable "vm_netmask" {
#   description = "Netmask used for the vSphere virtual machine (example: 24)"
#   type        = string
# }

# variable "vm_gateway" {
#   description = "Gateway for the vSphere virtual machine"
#   type        = string
# }

# variable "vm_dns" {
#   description = "DNS for the vSphere virtual machine"
#   type        = list(string)
# }

# variable "vm_domain" {
#   description = "Domain for the vSphere virtual machine"
#   type        = string
# }

# variable "dns_suffix" {
#   description = "Domain search list"
#   type        = list(string)
# }

# variable "vm_name" {
#   description = "The name of the vSphere virtual machines and the hostname of the machine"
#   type        = string
# }

# variable "ssh_username" {
#   description = "ssh user for the guest"
#   type        = string
# }

# variable "instance_count" {
#   description = "The number of vSphere guest machines"
#   type        = string
# }

