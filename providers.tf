provider "aviatrix" {
  controller_ip           = "18.198.44.55"
  username                = "admin"
  password                = var.ctlpassword
  skip_version_validation = false
}
