pipeline {
    agent any
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
                                sh "cd ${f.name} && terraform validate"

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
                                sh "ansible-playbook ${f.name}/main.yml --check"

                                echo "Using Ansible Lint on project: ${f.name}"
                                sh 'ansible-lint ${f.name}/playbooks/*.yml'
                            }
                        }
                    }
                }
            }
        }

        stage('InfraPlan') {
            steps {
                echo 'InfraPlan step'
            }
        }

        stage('InfraProvision') {
            steps {
                echo 'InfraProvision step'
            }
        }

        stage('InfraDestroy') {
            steps {
                echo 'InfraDestroy step'
            }
        }
    }
}
