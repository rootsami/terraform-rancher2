variable "openstack_project" {
  type = string
  description = "Openstack project/tenant name"
}
variable "openstack_username" {
  type = string
  description = "Openstack username which resources will be created by"
}
variable "openstack_password" {
  type = string
  description = "Openstack password"
}
variable "openstack_auth_url" {
  type = string
  description = "Authentication url for openstack cli"
}
variable "openstack_domain" {
  type = string
  description = "Openstack domain name which tenant exists on"
}

# Openstack provider to communicate with openstack apis
provider "openstack" {
  user_name   = var.openstack_username
  tenant_name = var.openstack_project
  password    = var.openstack_password
  auth_url    = var.openstack_auth_url
  domain_name = var.openstack_domain
}
