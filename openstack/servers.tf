
resource "openstack_networking_floatingip_v2" "rancher_server_ip" {
  pool = var.ip_pool_name
}

resource "openstack_networking_floatingip_v2" "rancher_master_ips" {
  count = var.count_master
  pool  = var.ip_pool_name
}

resource "openstack_networking_floatingip_v2" "rancher_workers_ips" {
  count = var.count_worker_nodes
  pool  = var.ip_pool_name
}

resource "openstack_compute_floatingip_associate_v2" "rancher_master_ips_attach" {
  count       = var.count_master
  floating_ip = openstack_networking_floatingip_v2.rancher_master_ips[count.index].address
  instance_id = openstack_compute_instance_v2.rancher_master[count.index].id
  depends_on  = [openstack_compute_instance_v2.rancher_master]
}

resource "openstack_compute_floatingip_associate_v2" "rancher_workers_ips_attach" {
  count       = var.count_worker_nodes
  floating_ip = openstack_networking_floatingip_v2.rancher_workers_ips[count.index].address
  instance_id = openstack_compute_instance_v2.rancher_worker[count.index].id
  depends_on  = [openstack_compute_instance_v2.rancher_worker]
}

resource "openstack_compute_floatingip_associate_v2" "rancher_server_ip_attach" {
  floating_ip = openstack_networking_floatingip_v2.rancher_server_ip.address
  instance_id = openstack_compute_instance_v2.rancher_server[0].id
  depends_on  = [openstack_compute_instance_v2.rancher_server]
}


resource "openstack_compute_instance_v2" "rancher_server" {
  count           = "1"
  name            = "${var.prefix}-rancherserver"
  flavor_name     = var.rancher_server_flavor
  key_pair        = openstack_compute_keypair_v2.demo_keypair.name
  security_groups = [openstack_networking_secgroup_v2.demo_secgroup.name]
  user_data       = data.template_file.cloud-config-rancher.rendered

  block_device {

    uuid                  = var.rancher_node_image_id
    source_type           = "image"
    volume_size           = 50
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = false
  }

  network {
    name = openstack_networking_network_v2.demo_network.name
  }

  lifecycle {
    ignore_changes = [
      user_data,
    ]
  }

  depends_on = [openstack_compute_keypair_v2.demo_keypair, openstack_networking_subnet_v2.demo_subnet, openstack_networking_floatingip_v2.rancher_server_ip]
}

resource "openstack_compute_instance_v2" "rancher_master" {
  count           = var.count_master
  name            = "${var.prefix}-master-${count.index + 1}"
  flavor_name     = var.rancher_master_flavor
  key_pair        = openstack_compute_keypair_v2.demo_keypair.name
  security_groups = [openstack_networking_secgroup_v2.demo_secgroup.name]
  user_data       = data.template_file.cloud-config-master.rendered

  block_device {

    uuid                  = var.rancher_node_image_id
    source_type           = "image"
    volume_size           = 50
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = false
  }

  network {
    name = openstack_networking_network_v2.demo_network.name
  }

  lifecycle {
    ignore_changes = [
      user_data,
    ]
  }

  depends_on = [openstack_compute_keypair_v2.demo_keypair, openstack_networking_subnet_v2.demo_subnet, openstack_networking_floatingip_v2.rancher_master_ips]
}

resource "openstack_compute_instance_v2" "rancher_worker" {
  count           = var.count_worker_nodes
  name            = "${var.prefix}-worker-${count.index + 1}"
  flavor_name     = var.rancher_worker_flavor
  key_pair        = openstack_compute_keypair_v2.demo_keypair.name
  security_groups = [openstack_networking_secgroup_v2.demo_secgroup.name]
  user_data       = data.template_file.cloud-config-worker.rendered

  block_device {

    uuid                  = var.rancher_node_image_id
    source_type           = "image"
    volume_size           = 50
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = false
  }

  network {
    name = openstack_networking_network_v2.demo_network.name
  }

  lifecycle {
    ignore_changes = [
      user_data,
    ]
  }

  depends_on = [openstack_compute_keypair_v2.demo_keypair, openstack_networking_subnet_v2.demo_subnet, openstack_networking_floatingip_v2.rancher_workers_ips]
}


output "rancher_url" {
  value = ["https://${openstack_networking_floatingip_v2.rancher_server_ip.address}"]
}