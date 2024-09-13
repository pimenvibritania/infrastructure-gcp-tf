resource "google_sql_database_instance" "postgres_instance" {
  name             = "postgres-${local.env}-instance"
  database_version = "POSTGRES_13"
  region           = local.region

  settings {
    tier = "db-f1-micro"  
    disk_size = 10
    disk_type = "PD_SSD"
    availability_type = "ZONAL" 

    backup_configuration {
      enabled = true
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.main.id  
      enable_private_path_for_google_cloud_services = true
    }
  }

  depends_on = [
    google_project_service.enable_sql_admin,
    google_project_service.enable_vpc_access,
    google_project_service.enable_networking_access,
    google_service_networking_connection.private_vpc_connection
  ]

}

resource "google_sql_database" "default_db" {
  name     = "sre-application"
  instance = google_sql_database_instance.postgres_instance.name
}

resource "google_sql_user" "postgres_user" {
  name     = "sre-application-user"
  instance = google_sql_database_instance.postgres_instance.name
  password = "kmzway87aa"
}

# Enable required APIs for Cloud SQL and VPC access
resource "google_project_service" "enable_sql_admin" {
  service = "sqladmin.googleapis.com"
  project = local.project
}

resource "google_project_service" "enable_vpc_access" {
  service = "vpcaccess.googleapis.com"
  project = local.project
}

resource "google_project_service" "enable_networking_access" {
  service = "servicenetworking.googleapis.com"
  project = local.project
}