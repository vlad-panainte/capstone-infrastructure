# tflint-ignore-file: terraform_required_version, terraform_required_providers
resource "google_compute_network" "vpc" {
  name                    = "vpanainte-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_1" {
  name = "vpanainte-subnet-1"

  ip_cidr_range    = "10.0.0.0/24"
  stack_type       = "IPV4_IPV6"
  ipv6_access_type = "EXTERNAL"

  network = google_compute_network.vpc.id
}

resource "google_compute_firewall" "firewall_v4" {
  name = "vpanainte-firewall-v4"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  network = google_compute_network.vpc.name
}

resource "google_compute_firewall" "firewall_v6" {
  name = "vpanainte-firewall-v6"

  allow {
    # protocol 58 is ICMPv6
    protocol = "58"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["::/0"]

  network = google_compute_network.vpc.name
}

resource "google_compute_firewall" "jenkins-http-https" {
  name = "vpanainte-jenkins-http-https"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges      = ["0.0.0.0/0"]
  destination_ranges = ["10.0.0.2/32"]

  network = google_compute_network.vpc.name
}

resource "google_compute_firewall" "jenkins-quic" {
  name = "vpanainte-jenkins-quic"

  allow {
    protocol = "udp"
    ports    = ["443"]
  }

  source_ranges      = ["0.0.0.0/0"]
  destination_ranges = ["10.0.0.2/32"]

  network = google_compute_network.vpc.name
}
