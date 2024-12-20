variable "terraform_state_bucket_name" {
  type        = string
  description = "Terraform state storage bucket name"
}

variable "terraform_state_bucket_location" {
  type        = string
  description = "Terraform state storage bucket location"
  default     = "EU"
}
