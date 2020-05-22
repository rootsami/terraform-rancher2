
resource "openstack_networking_secgroup_v2" "demo_secgroup" {
  name        = "demo"
  description = "demo security group"
}


resource "openstack_networking_secgroup_rule_v2" "https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  security_group_id = openstack_networking_secgroup_v2.demo_secgroup.id
  depends_on        = [openstack_networking_secgroup_v2.demo_secgroup]
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  security_group_id = openstack_networking_secgroup_v2.demo_secgroup.id
  depends_on        = [openstack_networking_secgroup_v2.demo_secgroup]
}

resource "openstack_networking_secgroup_rule_v2" "same_secgroup_ingress_tcp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_group_id   = openstack_networking_secgroup_v2.demo_secgroup.id
  security_group_id = openstack_networking_secgroup_v2.demo_secgroup.id
  depends_on        = [openstack_networking_secgroup_v2.demo_secgroup]
}

resource "openstack_networking_secgroup_rule_v2" "same_secgroup_ingress_udp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  remote_group_id   = openstack_networking_secgroup_v2.demo_secgroup.id
  security_group_id = openstack_networking_secgroup_v2.demo_secgroup.id
  depends_on        = [openstack_networking_secgroup_v2.demo_secgroup]
}
