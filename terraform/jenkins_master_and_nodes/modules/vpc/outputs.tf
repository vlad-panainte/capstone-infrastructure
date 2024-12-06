output "vpc_id" {
  value       = google_compute_network.vpc.id
  description = "Default VPC ID"
}

output "subnet_id" {
  value       = google_compute_subnetwork.subnet_1.id
  description = "Default subnet ID"
}
