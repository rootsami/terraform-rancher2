# Creating Openstack keypair based on provided public ssh key
resource "openstack_compute_keypair_v2" "demo_keypair" {
  name       = "demo_keypair"
  public_key = var.public_key
}