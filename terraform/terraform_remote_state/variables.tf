variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "terraform_state_bucket_name_jenkins" {
  type    = string
  default = "Terraform state storage bucket name for Jenkins infrastructure"
}

variable "terraform_state_bucket_name_app" {
  type    = string
  default = "Terraform state storage bucket name for App infrastructure"
}

variable "terraform_state_bucket_location" {
  type        = string
  description = "Terraform state storage bucket location"
  default     = "EU"
}
