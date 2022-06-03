variable "azure_region" {
  type    = string
  default = "East US"
}

variable "gcp_region" {
  type    = string
  default = "us-east1"
}

locals {
  azure_account = data.terraform_remote_state.management_deployment.outputs.account_name
  gcp_account   = data.terraform_remote_state.management_deployment.outputs.gcp_account_name
  vnet_id       = data.terraform_remote_state.management_deployment.outputs.vnet_id
  gw_subnet     = data.terraform_remote_state.management_deployment.outputs.gw_subnet
  ha_gw_subnet  = data.terraform_remote_state.management_deployment.outputs.ha_gw_subnet
  mgmt_region   = data.terraform_remote_state.management_deployment.outputs.region

  spokes = {
    azure_spoke_1 = {
      cloud      = "Azure",
      name       = "azure-Spoke-1",
      cidr       = "10.1.0.0/16",
      region     = var.azure_region,
      account    = local.azure_account,
      transit_gw = module.transit_adoption_framework.transit["azure_transit_firenet"].transit_gateway.gw_name,
    },
    gcp_spoke_1 = {
      cloud      = "GCP",
      name       = "gcp-spoke-1",
      cidr       = "10.2.0.0/16",
      region     = var.gcp_region,
      account    = local.gcp_account,
      transit_gw = module.transit_adoption_framework.transit["gcp_transit_firenet"].transit_gateway.gw_name,
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

