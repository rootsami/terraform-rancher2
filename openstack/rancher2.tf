provider "rancher2" {
  alias     = "bootstrap"
  api_url   = "https://${openstack_networking_floatingip_v2.rancher_server_ip.address}"
  bootstrap = true
  insecure  = true
}

resource "rancher2_bootstrap" "admin" {
  provider   = rancher2.bootstrap
  password   = var.rancher_admin_password
  depends_on = [openstack_compute_floatingip_associate_v2.rancher_server_ip_attach, null_resource.wait_for_rancher]
}

provider "rancher2" {
  alias     = "admin"
  api_url   = rancher2_bootstrap.admin.url
  token_key = rancher2_bootstrap.admin.token
  insecure  = true
}

resource "null_resource" "wait_for_rancher" {
  provisioner "local-exec" {
    command    = "until $(curl --output /dev/null --silent --head --insecure --fail https://${openstack_networking_floatingip_v2.rancher_server_ip.address}); do sleep 5 ;done"
  }
  depends_on = [openstack_compute_floatingip_associate_v2.rancher_server_ip_attach]

}


resource "rancher2_cluster" "demo" {
  provider                  = "rancher2.admin"
  name                      = var.cluster_name
  description               = "${var.prefix} rancher2 rke cluster"
  enable_cluster_monitoring = true
  rke_config {
    network {
      plugin = "canal"
    }
    services {
      kubelet {
        extra_args = {
          cloud-provider = "external"
        }
      }
    }
  }
}

