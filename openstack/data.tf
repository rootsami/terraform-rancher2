# Retrieving external network infromation 
data "openstack_networking_network_v2" "external_network" {
  name = var.external_network
}

# Cloud-init file for Worker instances. 
# Installs the required packages, Imports SSH key, and registers node to the cluster based on its roles
data "template_file" "cloud-config-worker" {
  template = file("./configs/worker-cloud-init.yaml")
  vars = {
    ssh_public_key = openstack_compute_keypair_v2.demo_keypair.public_key
    register_cmd   = "${rancher2_cluster.demo.cluster_registration_token.0.node_command} --worker"
  }
  depends_on = [rancher2_cluster.demo]
}

# Cloud-init file for Master instances. 
# Installs the required packages, Imports SSH key, and registers node to the cluster based on its roles
data "template_file" "cloud-config-master" {
  template = file("./configs/master-cloud-init.yaml")
  vars = {
    ssh_public_key = openstack_compute_keypair_v2.demo_keypair.public_key
    register_cmd   = "${rancher2_cluster.demo.cluster_registration_token.0.node_command} --etcd --controlplane"
  }
  depends_on = [rancher2_cluster.demo]
}

# Cloud-init file for Rancher2 server instance. 
# Installs the required packages, Imports SSH key, and Runs rancher2 docker container as systemd.service 
data "template_file" "cloud-config-rancher" {
  template = file("./configs/rancher-cloud-init.yaml")
  vars = {
    ssh_public_key  = openstack_compute_keypair_v2.demo_keypair.public_key
    rancher_version = var.rancher_version
  }
}
