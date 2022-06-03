output "password" {
  value = nonsensitive(random_password.password.result)
}

output "fw_management_ips_azure" {
  value = nonsensitive(module.transit_adoption_framework.firenet["azure_transit_firenet"].aviatrix_firewall_instance.*.public_ip)
}

# output "fw_management_ips_gcp" {
#   value = nonsensitive(module.transit_adoption_framework.firenet["gcp_transit_firenet"].aviatrix_firewall_instance.*.public_ip)
}

