terraform {
  required_version = "~> 1.10.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.14.1"
    }
  }
}

provider "google" {
  project = var.project_id
}

module "terraform_state_bucket_jenkins" {
  source                      = "./modules/storage_bucket"
  terraform_state_bucket_name = "vpanainte-tfstate-jenkins"
}

module "terraform_state_bucket_app" {
  source                      = "./modules/storage_bucket"
  terraform_state_bucket_name = "vpanainte-tfstate-app"
}

module "terraform_state_bucket_deployment" {
  source                      = "./modules/storage_bucket"
  terraform_state_bucket_name = "vpanainte-tfstate-deployment"
}
