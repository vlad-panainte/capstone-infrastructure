terraform {
  required_version = "~> 1.10.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.14.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

resource "google_storage_bucket" "terraform_state_bucket_jenkins" {
  name     = var.terraform_state_bucket_name_jenkins
  location = var.terraform_state_bucket_location

  force_destroy               = true
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket" "terraform_state_bucket_app" {
  name     = var.terraform_state_bucket_name_app
  location = var.terraform_state_bucket_location

  force_destroy               = true
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }
}
