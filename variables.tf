variable "azure_region" {
  type    = string
  default = "East US"
}

variable "gcp_region" {
  type    = string
  default = "us-east1"
}

variable "azure_account" {
  type    = string
  default = "Azure_Paul_Carvill"
}

variable "gcp_account" {
  default = "GCP_Paul"
}

 locals {
#   azure_account = data.terraform_remote_state.management_deployment.outputs.account_name
#   gcp_account   = data.terraform_remote_state.management_deployment.outputs.gcp_account_name
#   vnet_id       = data.terraform_remote_state.management_deployment.outputs.vnet_id
#   gw_subnet     = data.terraform_remote_state.management_deployment.outputs.gw_subnet
#   ha_gw_subnet  = data.terraform_remote_state.management_deployment.outputs.ha_gw_subnet
#   mgmt_region   = data.terraform_remote_state.management_deployment.outputs.region

  spokes = {
    azure_spoke_1 = {
      cloud      = "Azure",
      name       = "azure-CNE-Spoke-1",
      cidr       = "10.1.0.0/16",
      region     = var.azure_region,
      account    = var.azure_account,
      transit_gw = module.transit_adoption_framework.transit["azure_transit_firenet"].transit_gateway.gw_name,
    },
    gcp_spoke_1 = {
      cloud      = "GCP",
      name       = "gcp-CNE-spoke-1",
      cidr       = "10.5.0.0/16",
      region     = var.gcp_region,
      account    = var.gcp_account,
      transit_gw = module.transit_adoption_framework.transit["gcp_transit_firenet"].transit_gateway.gw_name,
    },
    azure_spoke_2 = {
      cloud      = "Azure",
      name       = "azure-CNE-Spoke-2",
      cidr       = "10.2.0.0/16",
      region     = var.azure_region,
      account    = var.azure_account,
      transit_gw = module.transit_adoption_framework.transit["azure_transit_firenet"].transit_gateway.gw_name,
    },
    gcp_spoke_2 = {
      cloud      = "GCP",
      name       = "gcp-CNE-spoke-2",
      cidr       = "10.6.0.0/16",
      region     = var.gcp_region,
      account    = var.gcp_account,
      transit_gw = module.transit_adoption_framework.transit["gcp_transit_firenet"].transit_gateway.gw_name,
    },
     azure_spoke_3 = {
      cloud      = "Azure",
      name       = "azure-DCX-Spoke-1",
      cidr       = "10.2.0.0/16",
      region     = var.azure_region,
      account    = var.azure_account,
      transit_gw = module.transit_adoption_framework.transit["mtt_azure"].transit_gateway.gw_name,
    },
    gcp_spoke_3 = {
      cloud      = "GCP",
      name       = "gcp-DCX-spoke-1",
      cidr       = "10.6.0.0/16",
      region     = var.gcp_region,
      account    = var.gcp_account,
      transit_gw = module.transit_adoption_framework.transit["mtt_gcp"].transit_gateway.gw_name,
    },
    azure_spoke_4 = {
      cloud      = "Azure",
      name       = "azure-DCX-Spoke-2",
      cidr       = "10.3.0.0/16",
      region     = var.azure_region,
      account    = var.azure_account,
      transit_gw = module.transit_adoption_framework.transit["mtt_azure"].transit_gateway.gw_name,
    },
    gcp_spoke_4 = {
      cloud      = "GCP",
      name       = "gcp-DCX-spoke-2",
      cidr       = "10.7.0.0/16",
      region     = var.gcp_region,
      account    = var.gcp_account,
      transit_gw = module.transit_adoption_framework.transit["mtt_azure"].transit_gateway.gw_name,
    },
  }

  azure_fw1 = templatefile("fortigate_bootstrap.tpl", {
    name     = "Azure-FW1"
    password = random_password.password.result
    }
  )
  azure_fw2 = templatefile("fortigate_bootstrap.tpl", {
    name     = "Azure-FW2"
    password = random_password.password.result
    }
  )
  gcp_fw1 = templatefile("fortigate_bootstrap.tpl", {
    name     = "GCP-FW1"
    password = random_password.password.result
    }
  )
  gcp_fw2 = templatefile("fortigate_bootstrap.tpl", {
    name     = "GCP-FW2"
    password = random_password.password.result
    }
  )
 }


