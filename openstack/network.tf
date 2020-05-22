resource "openstack_networking_network_v2" "demo_network" {
  name           = "demo"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "demo_subnet" {
  name       = "demo"
  network_id = openstack_networking_network_v2.demo_network.id
  cidr       = "192.168.201.0/24"
  ip_version = 4
  depends_on = [openstack_networking_network_v2.demo_network]
}

resource "openstack_networking_router_v2" "demo_router" {
  name                = "demo"
  external_network_id = data.openstack_networking_network_v2.external_network.id
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = openstack_networking_router_v2.demo_router.id
  subnet_id = openstack_networking_subnet_v2.demo_subnet.id
}
