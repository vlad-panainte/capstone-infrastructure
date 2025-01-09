terraform {
  required_version = "~> 1.10.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.15.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_monitoring_dashboard" "name" {
  dashboard_json = file(var.dashboard_json_file_path)
}
