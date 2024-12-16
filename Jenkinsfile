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
                                sh "yamlfmt ${f.directory}/"
                            }
                        }
                    }
                }
            }
        }

        stage('CodeLint') {
            steps {
                echo 'CodeLint step'
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
