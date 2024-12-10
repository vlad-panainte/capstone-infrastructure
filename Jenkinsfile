pipeline {
    agent any
    stages {
        stage('CodeFormat') {
            steps {
                script {
                    checkout scm
                    dir('./terraform') {
                        def files = findFiles()

                        files.each { f->
                            if (f.directory) {
                                echo "Terraform projects: ${f.name}"
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
