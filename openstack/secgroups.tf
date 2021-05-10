# Creating Openstack security groups
resource "openstack_networking_secgroup_v2" "demo_secgroup" {
  name        = "${var.prefix}-demo"
  description = "demo security group"
}

# Creating Openstack security group rule for https 443
resource "openstack_networking_secgroup_rule_v2" "https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  security_group_id = openstack_networking_secgroup_v2.demo_secgroup.id
  depends_on        = [openstack_networking_secgroup_v2.demo_secgroup]
}

# Creating Openstack security group rule for ssh 22
resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  security_group_id = openstack_networking_secgroup_v2.demo_secgroup.id
  depends_on        = [openstack_networking_secgroup_v2.demo_secgroup]
}

# Creating Openstack security group rule for all ports in same security group tcp
resource "openstack_networking_secgroup_rule_v2" "same_secgroup_ingress_tcp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_group_id   = openstack_networking_secgroup_v2.demo_secgroup.id
  security_group_id = openstack_networking_secgroup_v2.demo_secgroup.id
  depends_on        = [openstack_networking_secgroup_v2.demo_secgroup]
}

# Creating Openstack security group rule for all ports in same security group udp
resource "openstack_networking_secgroup_rule_v2" "same_secgroup_ingress_udp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  remote_group_id   = openstack_networking_secgroup_v2.demo_secgroup.id
  security_group_id = openstack_networking_secgroup_v2.demo_secgroup.id
  depends_on        = [openstack_networking_secgroup_v2.demo_secgroup]
}
