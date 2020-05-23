# please fill these variables or use TF_VARS_ prefix to be exported env variables
# openstack_project = ""
# openstack_username = ""
# openstack_password = ""
openstack_auth_url = "https://api-url-openstack.com/identity/v3"
openstack_domain   = "domain"
public_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFiJPJGZ...." ## default location ~/.ssh/id_rsa.pub


# Nodes server Image ID
rancher_node_image_id = "ed260692-db71-4be7-9283-0999ce828ff7" ## f99bb6f7-658d-4f7c-840d-...
# Count of agent nodes with role master (controlplane,etcd)
count_master = "1"
# Count of agent nodes with role worker
count_worker_nodes = "2"
# Resources will be prefixed with this to avoid clashing names
prefix = "demo"

# Name of floating IP pool
ip_pool_name = "Public_Network"
# ID of External Network
external_network = "Public_Network"

# Instances' flavor size
rancher_master_flavor = "R1-Generic-8"
rancher_worker_flavor = "R1-Generic-8"
rancher_server_flavor = "R1-Generic-8"

# Admin password to access Rancher
rancher_admin_password = "admin123"
# Name of custom cluster that will be created
cluster_name = "demo"
# rancher/rancher image tag to use
rancher_version = "v2.4.3"
