terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.2"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

# Global data sources (lookups) – fetched once and shared
data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_datastore" "ds" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "net" {
  name          = var.vlan_portgroup_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Instantiate three VMs using the windows_vm module
module "vm1" {
  source              = "./modules/windows_vm"
  # VM-specific settings
  vm_name             = var.vm1_config.name
  vm_cpu              = var.vm1_config.cpu
  vm_memory           = var.vm1_config.memory
  vm_disk0_size       = var.vm1_config.disk0_size
  vm_disk1_size       = var.vm1_config.disk1_size
  vm_ip               = var.vm1_config.ip
  vm_gateway          = var.vm1_config.gateway
  vm_subnet_mask      = var.vm1_config.subnet_mask
  vm_dns_servers      = var.vm1_config.dns_servers
  vm_dns_suffix_list  = var.vm1_config.dns_suffix_list
  # Global (shared) settings
  datacenter          = var.datacenter
  datastore           = var.datastore
  cluster             = var.cluster
  vlan_portgroup_name = var.vlan_portgroup_name
  template            = var.template
  domain_name         = var.domain_name
  domain_user         = var.domain_user
  domain_password     = var.domain_password
  domain_ou           = var.domain_ou
  local_admin_password = var.local_admin_password
  ansible_control_ip = var.ansible_control_ip
}

module "vm2" {
  source              = "./modules/windows_vm"
  vm_name             = var.vm2_config.name
  vm_cpu              = var.vm2_config.cpu
  vm_memory           = var.vm2_config.memory
  vm_disk0_size       = var.vm2_config.disk0_size
  vm_disk1_size       = var.vm2_config.disk1_size
  vm_ip               = var.vm2_config.ip
  vm_gateway          = var.vm2_config.gateway
  vm_subnet_mask      = var.vm2_config.subnet_mask
  vm_dns_servers      = var.vm2_config.dns_servers
  vm_dns_suffix_list  = var.vm2_config.dns_suffix_list
  datacenter          = var.datacenter
  datastore           = var.datastore
  cluster             = var.cluster
  vlan_portgroup_name = var.vlan_portgroup_name
  template            = var.template
  domain_name         = var.domain_name
  domain_user         = var.domain_user
  domain_password     = var.domain_password
  domain_ou           = var.domain_ou
  local_admin_password = var.local_admin_password
  ansible_control_ip = var.ansible_control_ip
}

# module "vm3" {
#   source              = "./modules/sql_vm"
#   vm_name             = var.vm3_config.name
#   vm_cpu              = var.vm3_config.cpu
#   vm_memory           = var.vm3_config.memory
#   vm_disk0_size       = var.vm3_config.disk0_size
#   vm_disk1_size       = var.vm3_config.disk1_size
#   vm_disk2_size       = var.vm3_config.disk2_size
#   vm_disk3_size       = var.vm3_config.disk3_size
#   vm_ip               = var.vm3_config.ip
#   vm_gateway          = var.vm3_config.gateway
#   vm_subnet_mask      = var.vm3_config.subnet_mask
#   vm_dns_servers      = var.vm3_config.dns_servers
#   vm_dns_suffix_list  = var.vm3_config.dns_suffix_list
#   datacenter          = var.datacenter
#   datastore           = var.datastore
#   cluster             = var.cluster
#   vlan_portgroup_name = var.vlan_portgroup_name
#   template            = var.template
#   domain_name         = var.domain_name
#   domain_user         = var.domain_user
#   domain_password     = var.domain_password
#   domain_ou           = var.domain_ou
#   local_admin_password = var.local_admin_password
# }