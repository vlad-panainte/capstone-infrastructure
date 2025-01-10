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

variable "dashboard_json_file_path" {
  type        = string
  description = "GCP Dashboard json file path"
}
