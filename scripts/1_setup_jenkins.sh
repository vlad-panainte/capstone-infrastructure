#!/bin/bash
set -euo pipefail

echo '-> Provisioning cloud resources for Jenkins master and slave nodes'
terraform -chdir=../terraform/jenkins_master_and_nodes apply --auto-approve

cd ../ansible/jenkins_master_and_nodes
echo '-> Configuring Jenkins master and slave nodes'
ansible-playbook ./playbooks/main.yml
