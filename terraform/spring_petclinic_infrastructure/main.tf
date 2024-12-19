terraform {
  required_version = "~> 1.10.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.14.0"
    }
  }
  backend "gcs" {
    bucket = "vpanainte-terraform-state-app"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "artifact_repository" {
  source                          = "./modules/artifact_repository"
  artifact_repository_id          = "vpanainte-spring-petclinic"
  artifact_repository_description = "Repository for storing docker images for Spring-Petclinic application"
}
