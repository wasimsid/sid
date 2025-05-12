# vSphere credentials and server
vsphere_user     = "e2wip@agfirst.net"
vsphere_password = ""
vsphere_server   = "imdutvmw01.agfirst.net"

# vSphere environment specifics
datacenter          = "AgFirst_QALab"
datastore           = "QPURE-INFRA01"
cluster             = "QA_DEV_INFRA"
template            = "Win2k19_DDE_TEMPL_iac"
vlan_portgroup_name = "dvPortGroup885"

# Domain and admin settings (shared for all VMs)
domain_name         = "agf-test.local"
domain_user         = "AGFIRST\\e2wip"
domain_password     = ""
domain_ou           = "OU=District Servers,OU=Global Services,DC=agf-test,DC=local"
local_admin_password = ""

# WinRM credentials (if needed for post-provision configuration)
winrm_user     = "p3fga"
winrm_password = ""

# Ansible Control Node IP
ansible_control_ip = "10.207.86.155" 

# Individual VM configurations
vm1_config = {
  name            = "test-vm-01"
  cpu             = 2
  memory          = 4096
  disk0_size      = 100
  disk1_size      = 10
  ip              = "10.207.85.12"
  gateway         = "10.207.85.1"
  subnet_mask     = 24
  dns_servers     = ["10.200.6.75", "10.200.6.24"]
  dns_suffix_list = ["agf-test.local"]
}

vm2_config = {
  name            = "test-vm-02"
  cpu             = 2
  memory          = 4096
  disk0_size      = 100
  disk1_size      = 10
  ip              = "10.207.85.13"
  gateway         = "10.207.85.1"
  subnet_mask     = 24
  dns_servers     = ["10.200.6.75", "10.200.6.24"]
  dns_suffix_list = ["agf-test.local"]
}

vm3_config = {
  name            = "test-vm-03"
  cpu             = 2
  memory          = 4096
  disk0_size      = 100
  disk1_size      = 100
  disk2_size      = 100
  disk3_size      = 100
  ip              = "10.207.85.14"
  gateway         = "10.207.85.1"
  subnet_mask     = 24
  dns_servers     = ["10.200.6.75", "10.200.6.24"]
  dns_suffix_list = ["agf-test.local"]
}
