# tflint-ignore-file: terraform_required_version, terraform_required_providers
resource "google_compute_instance" "jenkins" {
  name         = var.jenkins_instance_name
  machine_type = var.jenkins_instance_type

  network_interface {
    subnetwork = var.subnet_id
    access_config {
      nat_ip = var.jenkins_public_ip
    }
    network_ip = var.jenkins_internal_ip
  }

  boot_disk {
    initialize_params {
      image = var.jenkins_image
    }
  }

  labels = {
    capstone = var.jenkins_instance_id
  }
}
