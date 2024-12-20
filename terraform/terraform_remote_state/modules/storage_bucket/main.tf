# tflint-ignore-file: terraform_required_version, terraform_required_providers
resource "google_storage_bucket" "terraform_state_bucket" {
  name     = var.terraform_state_bucket_name
  location = var.terraform_state_bucket_location

  force_destroy               = true
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }
}
