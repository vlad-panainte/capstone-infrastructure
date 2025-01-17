variable "subnet_id" {
  type        = string
  description = "Default subnet ID"
}

variable "jenkins_instance_name" {
  type        = string
  description = "Jenkins instance name"
}

variable "jenkins_instance_type" {
  type        = string
  description = "Jenkins instance type"
  default     = "e2-small"
}

variable "jenkins_internal_ip" {
  type        = string
  description = "Jenkins instance internal ip"
  default     = null
}

variable "jenkins_public_ip" {
  type        = string
  description = "Jenkins instance public ip"
}

variable "jenkins_image" {
  type        = string
  description = "Boot disk image"
  default     = "ubuntu-os-cloud/ubuntu-minimal-2410-oracular-amd64-v20241115"
}

variable "jenkins_instance_id" {
  type        = string
  description = "Instance ID"

}
