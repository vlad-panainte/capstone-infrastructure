variable "credentials_file" {
  type        = string
  description = "Service account JSON file"
}

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
