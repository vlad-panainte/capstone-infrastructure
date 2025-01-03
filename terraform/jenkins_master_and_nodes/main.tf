terraform {
  required_version = "~> 1.10.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.14.1"
    }
  }
  backend "gcs" {
    bucket = "vpanainte-tfstate-jenkins"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "vpc" {
  source = "./modules/vpc"
}

module "jenkins_master" {
  source = "./modules/instance"

  subnet_id             = module.vpc.subnet_id
  jenkins_instance_name = "vpanainte-jenkins-master"
  jenkins_instance_id   = "jenkins-master"
  jenkins_internal_ip   = "10.0.0.2"
}

module "jenkins_node" {
  source = "./modules/instance"
  count  = var.jenkins_nodes_number

  subnet_id             = module.vpc.subnet_id
  jenkins_instance_name = "vpanainte-jenkins-node-${count.index + 1}"
  jenkins_instance_id   = "jenkins-node"
  jenkins_instance_type = "e2-highcpu-4"
  jenkins_internal_ip   = "10.0.0.${count.index + 3}"
}
