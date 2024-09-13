resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "main" {
  name                            = "main"
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}

data "google_compute_network" "private_network" {
  name = google_compute_network.main.name
}

# Reserve a range of IPs for Private Service Access
resource "google_compute_global_address" "private_ip_address_cloudsql" {
  name          = "private-ip-address-cloudsql"
  project       = local.project
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = data.google_compute_network.private_network.id
}

# Create VPC Peering between your VPC and Google's service networking
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = data.google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address_cloudsql.name]
}
