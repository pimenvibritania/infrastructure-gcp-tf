locals {
  # env = "development"
  env = "production"

  # project = "sre-development-2613"
  project = "sre-production-2613-435513"

  # cidr_range = "10.0.0.0/18" 
  cidr_range = "10.1.0.0/18"

  # pod_range = "10.48.0.0/14"
  pod_range = "10.56.0.0/14"

  # svc_range = "10.52.0.0/20"
  svc_range = "10.60.0.0/20"

  # master_ipv4_cidr_block = "172.16.0.0/28"
  master_ipv4_cidr_block = "172.17.0.0/28"

  region = "asia-southeast2"
  zone1 = "asia-southeast2-a"
  zone2 = "asia-southeast2-b"
  grit_sa = "grit-provisioner"
  grit_role_id = "GRITProvisioner"
}