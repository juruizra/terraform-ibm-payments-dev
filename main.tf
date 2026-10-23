module "vpc" {
  source = "github.com/juruizra/terraform-ibm-vpc-standard?ref=v1.0.0"

  name   = var.name
  region = var.region
  zone   = var.zone
  tags   = var.tags
}

resource "ibm_is_ssh_key" "payments" {
  name       = "${var.name}-key"
  public_key = var.ssh_public_key
}

resource "ibm_is_instance" "payments" {
  name    = "${var.name}-vsi"
  image   = "ibm-ubuntu-22-04-5-minimal-amd64-19"
  profile = var.instance_profile
  zone    = var.zone

  vpc = module.vpc.vpc_id

  primary_network_interface {
    subnet          = module.vpc.subnet_id
    security_groups = [module.vpc.security_group_id]
  }

  keys = [ibm_is_ssh_key.payments.id]
  tags = var.tags
}

resource "ibm_is_floating_ip" "payments" {
  name   = "${var.name}-fip"
  target = ibm_is_instance.payments.primary_network_interface[0].id
  tags   = var.tags
}
