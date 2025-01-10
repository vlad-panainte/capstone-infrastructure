variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "Region of the infrastructure"
}

variable "zone" {
  type        = string
  description = "Zone of the infrastructure"
}

variable "jenkins_nodes_number" {
  type        = number
  description = "Jenkins nodes amount"
}
variable "jenkins_master_static_public_ip" {
  type        = string
  description = "Jenkins master static public IP address"
}
