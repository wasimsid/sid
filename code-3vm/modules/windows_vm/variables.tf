# vSphere environment (passed in from root)
variable "datacenter" { type = string }
variable "datastore"  { type = string }
variable "cluster"    { type = string }
variable "vlan_portgroup_name" { type = string }
variable "template"   { type = string }

# Domain join settings
variable "domain_name"    { type = string }
variable "domain_user"    { type = string }
variable "domain_password"{ type = string }
variable "domain_ou"      { type = string }

# Local admin account password for the VM
variable "local_admin_password" { type = string }

# IP address of the Ansible control host (allowed to connect via WinRM)
variable "ansible_control_ip" {
  type = string
  description = "The IP address of the Ansible control host to allow through WinRM"
}

# VM-specific settings
variable "vm_name"        { type = string }
variable "vm_cpu"         { type = number }
variable "vm_memory"      { type = number }
variable "vm_disk0_size"  { type = number }
variable "vm_disk1_size"  { type = number }
variable "vm_ip"          { type = string }
variable "vm_gateway"     { type = string }
variable "vm_subnet_mask" { type = number }
variable "vm_dns_servers" { type = list(string) }
variable "vm_dns_suffix_list" { type = list(string) }