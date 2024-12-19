# tflint-ignore-file: terraform_required_version, terraform_required_providers
resource "google_artifact_registry_repository" "spring_petclinic" {
  repository_id = var.artifact_repository_id
  description   = var.artifact_repository_description
  format        = "Docker"
}
