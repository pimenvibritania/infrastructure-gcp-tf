# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = local.project
  region  = local.region
}

# https://www.terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {
    bucket = "terraform-state-development-2613"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.2.0"
    }
  }
}