variable "rancher_version" {
  default = "stable"
}

variable "cluster_name" {
  default = "rke_cluster"
}
variable "rancher_admin_password" {}

variable "prefix" {}

variable "count_worker_nodes" {
  default = "2"
}

variable "count_master" {
  default = "1"
}

variable "rancher_worker_flavor" {
  default = "R1-Generic-8"
}
variable "rancher_master_flavor" {
  default = "R1-Generic-8"
}
variable "rancher_server_flavor" {
  default = "R1-Generic-8"
}
variable "rancher_node_image_id" {}

variable "external_network" {
  default = "Public_Network"
}

variable "ip_pool_name" {
  default = "Public_Network"
}

variable "public_key" {}
