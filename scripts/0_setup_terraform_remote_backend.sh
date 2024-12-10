#!/bin/bash
set -euo pipefail

echo '-> Setting up GCP Cloud Storage bucket for Terraform remote backend'
terraform -chdir=../terraform/terraform_remote_state apply --auto-approve
