variable "credentials_file" {
  type        = string
  description = "Service account JSON file"
}

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "terraform_state_bucket_name" {
  type    = string
  default = "Terraform state storage bucket name"
}

variable "terraform_state_bucket_location" {
  type        = string
  description = "Terraform state storage bucket location"
  default     = "EU"
}
