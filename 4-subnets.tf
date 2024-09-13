# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "private" {
  name                     = "private"
  ip_cidr_range            = local.cidr_range
  region                   = local.region
  network                  = google_compute_network.main.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = local.pod_range
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = local.svc_range
  }
}
