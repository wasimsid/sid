# Data sources within module (use provided names to look up IDs in vSphere)
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

# Resource to deploy a Windows VM from template

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id

  num_cpus = var.vm_cpu
  memory   = var.vm_memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  # Connect network interface to specified port group
  network_interface {
    network_id   = data.vsphere_network.net.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  # Define disks (preserve thin provisioning from template)
  disk { 
    unit_number      = 0
    label            = "disk0"
    size             = var.vm_disk0_size
    eagerly_scrub    = false
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
  disk {
    unit_number      = 1
    label            = "disk1"
    size             = var.vm_disk1_size
    eagerly_scrub    = false
    thin_provisioned = data.vsphere_virtual_machine.template.disks.1.thin_provisioned
  }

  # Clone from template and customize guest OS
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      windows_options {
        computer_name         = var.vm_name
        admin_password        = var.local_admin_password
        join_domain           = var.domain_name
        domain_admin_user     = var.domain_user
        domain_admin_password = var.domain_password
        domain_ou             = var.domain_ou
        time_zone             = 035 # Eastern Time

        # Auto-logon to run post-clone configuration scripts
        auto_logon       = true
        auto_logon_count = 2

        # Run once commands to enable WinRM and configure firewall
        run_once_command_list = [
          "winrm quickconfig -q",
          "powershell.exe -ExecutionPolicy Bypass -Command \"Disable-NetFirewallRule -DisplayGroup 'Windows Remote Management'\"",
          "powershell.exe -ExecutionPolicy Bypass -Command \"New-NetFirewallRule -Name 'AllowWinRM5985' -DisplayName 'Allow WinRM HTTP from Ansible' -Protocol TCP -LocalPort 5985 -Direction Inbound -Action Allow -RemoteAddress '${var.ansible_control_ip}' -Profile Any\"",
          "powershell.exe -ExecutionPolicy Bypass -Command \"New-NetFirewallRule -Name 'AllowWinRM5986' -DisplayName 'Allow WinRM HTTPS from Ansible' -Protocol TCP -LocalPort 5986 -Direction Inbound -Action Allow -RemoteAddress '${var.ansible_control_ip}' -Profile Any\"",
	   "cmd /c netdom join %COMPUTERNAME% /domain:${var.domain_name} /OU:\"${var.domain_ou}\" /UserD:${var.domain_user} /PasswordD:${var.domain_password}",
           "shutdown /r /t 300 /c \"Restarting to complete WinRM and firewall configuration\""
        ]
      }
      network_interface {
        ipv4_address = var.vm_ip
        ipv4_netmask = var.vm_subnet_mask
      }
      ipv4_gateway    = var.vm_gateway
      dns_server_list = var.vm_dns_servers
      dns_suffix_list = var.vm_dns_suffix_list
    }
  }
}
