terraform {
  required_version = "~> 1.10.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.12.0"
    }
  }
  backend "gcs" {
    bucket = "vpanainte-terraform-state"
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

module "vpc" {
  source = "./modules/vpc"
}

module "jenkins_master" {
  source = "./modules/instance"

  subnet_id             = module.vpc.subnet_id
  jenkins_instance_name = "vpanainte-jenkins-master"
  jenkins_instance_id   = "jenkins-master"
}

module "jenkins_node" {
  source = "./modules/instance"
  count  = var.jenkins_nodes_number

  subnet_id             = module.vpc.subnet_id
  jenkins_instance_name = "vpanainte-jenkins-node-${count.index + 1}"
  jenkins_instance_id   = "jenkins-node"
  jenkins_instance_type = "e2-highcpu-4"
}
