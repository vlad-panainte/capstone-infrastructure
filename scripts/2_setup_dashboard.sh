#!/bin/bash
set -euo pipefail

echo '-> Provisioning cloud resources for Google Dashboard'
terraform -chdir=../terraform/dashboard apply --auto-approve
