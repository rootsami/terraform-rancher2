# Output Rancher Url to access login page
output "rancher_url" {
  value = ["https://${openstack_networking_floatingip_v2.rancher_server_ip.address}"]
}
