variable "gcp_services" {
  type = list(string)
  default = [
    "cloudkms.googleapis.com",
    "compute.googleapis.com", 
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iamcredentials.googleapis.com",
    "oslogin.googleapis.com",
    "compute.googleapis.com",
    "sqladmin.googleapis.com",
    "vpcaccess.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}

resource "google_project_service" "services" {
  for_each = toset(var.gcp_services)
  project = local.project
  service = each.key
}