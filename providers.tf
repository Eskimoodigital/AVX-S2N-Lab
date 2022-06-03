provider "aviatrix" {
  controller_ip           = data.terraform_remote_state.management_deployment.outputs.controller_public_ip
  username                = data.terraform_remote_state.management_deployment.outputs.admin_user
  password                = data.terraform_remote_state.management_deployment.outputs.admin_password
  skip_version_validation = false
}
