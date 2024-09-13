# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "gcs-sa-admin" {
  account_id = "gcs-sa-admin"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_member" "gcs-sa-admin" {
  project = local.project
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.gcs-sa-admin.email}"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam
resource "google_service_account_iam_member" "gcs-sa-admin" {
  service_account_id = google_service_account.gcs-sa-admin.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${local.project}.svc.id.goog[staging/gcs-sa-admin]"
}
