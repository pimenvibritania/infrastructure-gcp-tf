resource "google_service_account" "gitlab-runner" {
  account_id   = "gitlab-runner-sa"
  display_name = "Gitlab Runner SA for VM Instance"
}

resource "google_compute_instance" "gitlab-runner" {
  name         = "gitlab-runner"
  machine_type = "e2-standard-2"
  zone         = "asia-southeast2-a"

  tags = ["runner", "gitlab"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size = 15
    }
  }

  network_interface {
    network = google_compute_network.main.self_link
    subnetwork = google_compute_subnetwork.private.self_link

    access_config {
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.gitlab-runner.email
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}