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

variable "artifact_repository_id" {
  type        = string
  description = "ID of the Google Artifact Registry repository"
}

variable "artifact_repository_description" {
  type        = string
  description = "Description of the Google Artifact Registry repository"
}

variable "sql_database_name" {
  type        = string
  description = "Name of the Google Cloud SQL database"
}

variable "sql_user_name" {
  type        = string
  description = "Username of the Cloud SQL database user"
}

variable "sql_user_password" {
  type        = string
  description = "Password of the Cloud SQL database user"
}

variable "gke_name" {
  type        = string
  description = "Google Kubernetes Engine cluster name"
}
