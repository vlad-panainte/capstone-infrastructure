terraform {
  required_version = "~> 1.10.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.14.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }
  }
  backend "gcs" {
    bucket = "vpanainte-tfstate-app"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_artifact_registry_repository" "artifact_registry" {
  repository_id = var.artifact_repository_id
  description   = var.artifact_repository_description
  format        = "Docker"
}

resource "random_password" "random_root_password" {
  length           = 30
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "google_sql_database_instance" "cloud_sql" {
  name             = var.sql_database_name
  database_version = "MYSQL_8_4"
  root_password    = random_password.random_root_password.result
  settings {
    edition   = "ENTERPRISE"
    tier      = "db-g1-small"
    disk_size = "10"

    connector_enforcement = "REQUIRED"
    ip_configuration {
      ssl_mode = "TRUSTED_CLIENT_CERTIFICATE_REQUIRED"
    }

    location_preference {
      zone = var.zone
    }
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }
    password_validation_policy {
      enable_password_policy      = true
      min_length                  = 12
      complexity                  = "COMPLEXITY_DEFAULT"
      disallow_username_substring = true
    }
  }
  deletion_protection = false
}

resource "google_sql_user" "cloud_sql_user" {
  name     = var.sql_user_name
  password = var.sql_user_password
  host     = "%"
  instance = google_sql_database_instance.cloud_sql.name
}

resource "google_sql_database" "cloud_sql_database" {
  name     = "petclinic"
  instance = google_sql_database_instance.cloud_sql.name
}

data "google_compute_network" "vpc" {
  name = "vpanainte-vpc"
}

data "google_compute_subnetwork" "subnet_1" {
  name = "vpanainte-subnet-1"
}

resource "google_container_cluster" "main_cluster" {
  name = var.gke_name

  enable_autopilot         = true
  enable_l4_ilb_subsetting = true

  network    = data.google_compute_network.vpc.id
  subnetwork = data.google_compute_subnetwork.subnet_1.id

  deletion_protection = false
}
