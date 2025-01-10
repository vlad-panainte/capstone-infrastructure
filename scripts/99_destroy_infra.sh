#!/bin/bash
set -euo pipefail

echo '-> Destroying infrastructure'
terraform -chdir=../terraform/spring_petclinic_infrastructure destroy --auto-approve
terraform -chdir=../terraform/jenkins_master_and_nodes destroy --auto-approve
terraform -chdir=../terraform/dashboard destroy --auto-approve

# echo '-> Removing GCP Storage bucket used for Terraform remote state'
# terraform -chdir=../terraform/terraform_remote_state/ destroy --auto-approve
