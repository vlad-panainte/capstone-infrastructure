pipeline {
    agent any
    options {
        ansiColor('VGA')
    }
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp_service_account')
        GCP_SERVICE_ACCOUNT_FILE = credentials('gcp_service_account')
        SQL_CREDENTIALS = credentials('sql_credentials')
        GCP_AUTH_KIND = 'serviceaccount'
        TF_VAR_project_id = 'gd-gcp-internship-devops'
        TF_VAR_region = 'europe-central2'
        TF_VAR_zone = 'europe-central2-a'
        TF_VAR_jenkins_nodes_number = 2
        TF_VAR_artifact_repository_id = 'vpanainte-spring-petclinic'
        TF_VAR_artifact_repository_description = 'Repository for storing docker images for Spring-Petclinic application'
        TF_VAR_sql_database_name = 'vpanainte-mysql'
        TF_VAR_sql_user_name = '$SQL_CREDENTIALS_USR'
        TF_VAR_sql_user_password = '$SQL_CREDENTIALS_PSW'
        TF_VAR_gke_name = 'vpanainte-cluster'
    }
    stages {
        stage('CodeFormat') {
            steps {
                script {
                    dir('./terraform') {
                        def files = findFiles()

                        files.each { f->
                            if (f.directory) {
                                echo "Using terraform fmt on Terraform project: ${f.name}"
                                sh "terraform -chdir=${f.name} fmt"
                            }
                        }
                    }
                    dir('./ansible') {
                        def files = findFiles()

                        files.each { f->
                            if (f.directory) {
                                echo "Using yamlfmt on Ansible project: ${f.name}"
                                sh "yamlfmt ${f.name}/"
                            }
                        }
                    }
                }
            }
        }

        stage('CodeLint') {
            steps {
                script {
                    dir('./terraform') {
                        def files = findFiles()

                        files.each { f->
                            if (f.directory) {
                                echo "Validating Terraform project: ${f.name}"
                                sh "cd ${f.name} && terraform init && terraform validate"

                                echo "Using Terraform Lint on project: ${f.name}"
                                sh "tflint --chdir=${f.name} --recursive --fix"
                            }
                        }
                    }
                    dir('./ansible') {
                        def files = findFiles()

                        files.each { f->
                            if (f.directory) {
                                echo "Validating Ansible project: ${f.name}"
                                sh "cd ${f.name} && ansible-playbook playbooks/*.yml --syntax-check"

                                echo "Using Ansible Lint on project: ${f.name}"
                                sh "ansible-lint ${f.name}/playbooks/*.yml"
                            }
                        }
                    }
                }
            }
        }

        stage('InfraPlan') {
            steps {
                echo 'Planning the deployment of the application'
                sh 'terraform -chdir=terraform/spring_petclinic_infrastructure plan'
            }
        }

        stage('InfraProvision') {
            when {
                branch 'main'
            }
            steps {
                echo 'Attempting infrastructure provisioning'
                input message: 'Should we start the provisioning of the infrastructure?', ok: 'Yes'

                echo 'Starting the infrastructure provisioning for spring-petclinic application'
                sh 'terraform -chdir=terraform/spring_petclinic_infrastructure apply --auto-approve'
            }
        }

        stage('InfraDestroy') {
            when {
                branch 'main'
            }
            steps {
                echo 'Attempting infrastructure destruction'
                input message: 'Should we destroy the current the infrastructure?', ok: 'Yes'

                echo 'Starting to destroythe infrastructure for spring-petclinic application'
                sh 'terraform -chdir=terraform/spring_petclinic_infrastructure destroy --auto-approve'
            }
        }
    }
}
