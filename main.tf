# ── Networking (private module) ───────────────────────────────────────────────

module "vpc" {
  source  = "app.terraform.io/comoquiera/vpc-standard/ibm"
  version = "1.0.0"

  name   = var.name
  region = var.region
  zone   = var.zone
}

# ── SSH Key ───────────────────────────────────────────────────────────────────

resource "ibm_is_ssh_key" "payments" {
  name       = "${var.name}-key"
  public_key = var.ssh_public_key
}

# ── Image lookup ──────────────────────────────────────────────────────────────

data "ibm_is_image" "ubuntu" {
  name = "ibm-ubuntu-22-04-5-minimal-amd64-19"
}

# ── Virtual Server Instance ───────────────────────────────────────────────────

resource "ibm_is_instance" "payments" {
  name    = "${var.name}-vsi"
  image   = data.ibm_is_image.ubuntu.id
  profile = var.profile
  vpc     = module.vpc.vpc_id
  zone    = var.zone
  keys    = [ibm_is_ssh_key.payments.id]

  primary_network_interface {
    subnet = module.vpc.subnet_id
  }
}

# ── Floating IP (public) ──────────────────────────────────────────────────────

resource "ibm_is_floating_ip" "payments" {
  name   = "${var.name}-fip"
  target = ibm_is_instance.payments.primary_network_interface[0].id
}
