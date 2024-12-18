# tflint-ignore-file: terraform_required_version, terraform_required_providers
resource "google_artifact_registry_repository" "spring_petclinic" {
  repository_id = "vpanainte-spring-petclinic"
  description   = "Repository for storing docker images for Spring-Petclinic application"
  format        = "Docker"
}
