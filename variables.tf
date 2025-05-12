# vSphere provider credentials and target vCenter server
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}

# vSphere environment variables
variable "datacenter" {}
variable "datastore" {}
variable "cluster" {}
variable "template" {}
variable "vlan_portgroup_name" {
  description = "Name of the port group (VLAN) to attach the VM's network interface"
}

# Active Directory domain join settings (shared by all VMs)
variable "domain_name" {}
variable "domain_user" {}
variable "domain_password" {}
variable "domain_ou" {
  description = "OU (in DN format) to place the computer account in Active Directory (if supported by vSphere version)"
}

# IP address of the Ansible control host (allowed to connect via WinRM)
variable "ansible_control_ip" {
  type = string
  description = "The IP address of the Ansible control host to allow through WinRM"
}

# Local administrator account password for the VM
variable "local_admin_password" {}

# Optional WinRM credentials (not used in module, but available for post-provision configuration)
variable "winrm_user" {}
variable "winrm_password" {}

# Per-VM configuration objects for each VM (name, hardware, network settings)
variable "vm1_config" {
  description = "Configuration for VM1"
  type = object({
    name            = string
    cpu             = number
    memory          = number
    disk0_size      = number
    disk1_size      = number
    ip              = string
    gateway         = string
    subnet_mask     = number
    dns_servers     = list(string)
    dns_suffix_list = list(string)
  })
}

variable "vm2_config" {
  description = "Configuration for VM2"
  type = object({
    name            = string
    cpu             = number
    memory          = number
    disk0_size      = number
    disk1_size      = number
    ip              = string
    gateway         = string
    subnet_mask     = number
    dns_servers     = list(string)
    dns_suffix_list = list(string)
  })
}

variable "vm3_config" {
  description = "Configuration for VM3"
  type = object({
    name            = string
    cpu             = number
    memory          = number
    disk0_size      = number
    disk1_size      = number
    disk2_size      = number
    disk3_size      = number
    ip              = string
    gateway         = string
    subnet_mask     = number
    dns_servers     = list(string)
    dns_suffix_list = list(string)
  })
}
