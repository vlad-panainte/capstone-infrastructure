# Capstone project - Infrastructure

Create a CI/CD solution for spring-petclinic Java project and deploy a containerized application to the Cloud.

## Components
* [Infrastructure automation](#1-infrastructure-automation)
* [CI/CD solution](#2-cicd-solution)
* [Monitoring](#3-optional-monitoring)
* [Architecture diagram](#4-architecture-diagram)

|                                 |                                                                           |
|---------------------------------|---------------------------------------------------------------------------|
| **Source code**                 | Github, Gitlab                                                            |
| **Cloud**                       | GCP, AWS, Azure                                                           |
| **Infrastructure automation**   | Terraform                                                                 |
| **Remote state storage for TF** | Google Cloud Storage, AWS S3, Azure Blob Storage, GitLab managed TF state |
| **Configuration management**    | Ansible                                                                   |
| **CI/CD automation**            | GitLab, Jenkins                                                           |
| **Build tool**                  | Maven, Gradle                                                             |
| **Artifacts**                   | Docker images                                                             |
| **Artifact storage**            | Nexus, GitLab Container Registry, DockerHub, cloud based service          |
| **Persistent database**         | Cloud SQL, Azure Database, AWS RDS                                        |
| **Scripts**                     | Python, Bash                                                              |

## 1. Infrastructure automation
Create an infrastructure automation pipeline that prepares the environment for application deployment using the Infrastructure as Code approach. Infrastructure configuration should be in a separate repository from the application source code.

Some preparation steps can be done manually or by running automation scripts locally:
* If you’re going to use Amazon S3, Azure Blob Storage, or Google Cloud Storage as a remote state storage for Terraform, it should be created in advance.
* If you’re going to use GitLab SaaS (GitLab.com), you need a runner for your first job. In the beginning, it can be installed on your local machine.
* If you’re going to use Jenkins, then create a virtual machine, install Jenkins and take care of agents.

Use **Gitlab** or **Jenkins** to run the infrastructure provisioning pipeline. It should include the following jobs:
* configuration formatting
* *(OPTIONAL)* configuration validation and scanning
* plan
* *(MANUAL)* provisioning resources
* *(MANUAL)* destroying resources

Use **Terraform** to create the following resources in the cloud:
* a virtual machine with all the needed network-related resources and a Load Balancer (this VM will be used to host the application)
* a persistent database for the application
* *(OPTIONAL)* Additional virtual machine with all the needed network-related resources to run additional software like Gitlab runners, Nexus (if used)

Use **Ansible** to install additional software to the virtual machines including:
* Docker and docker-compose
* Jenkins with workers or Gitlab runners
* Nexus (if used)

## 2. CI/CD solution
A Continuous Integration and Continuous Delivery solution for the Java application [Spring Petclinic](https://github.com/vlad-panainte/capstone-spring_petclinic).

The repository with the spring-petclinic application source code should additionally have configuration files for Maven or Gradle and a Dockerfile.
In the artifact storage of your choice prepare a registry.

The pipeline for a pull request should include:
* static code analysis
* tests
* build
* creating an artifact (it can be tagged with a short commit hash)
* pushing the artifact to the artifact storage

The pipeline for the main branch should include:
* creating a Git tag in the repository using [Semantic Versioning](https://semver.org/) approach (a minor version increases on each commit). A python script with [semver · PyPI](https://pypi.org/project/semver/) can be used here.
* creating an artifact with Git tag representing the version
* pushing the artifact to the artifact storage
* a manual deployment job that:
    * connects to a virtual machine
    * checks if a previous version of the application is present and removes it
    * gets the image from the artifact storage
    * runs the application making sure it is connected to a MySQL database in the cloud
    * prints the link to the application

## 3. *(OPTIONAL)* Monitoring
Use a Cloud-based monitoring solution to create a dashboard with resource consumption metrics for the VM, where the spring-petclinic application is running.

## 4. Architecture diagram
Create an architecture diagram for your solution. The following resources can be used as a reference:
* [AWS Reference Architecture Diagrams](https://aws.amazon.com/architecture/reference-architecture-diagrams&sa=D&source=editors&ust=1732701939598982&usg=AOvVaw0bD_DnNu7B5wPaCzjFw92C)
* [GCP Cloud Reference Architectures and Diagrams](https://cloud.google.com/architecture&sa=D&source=editors&ust=1732701939599200&usg=AOvVaw2dmKUcTZsJwtqVmOi7ITR6)
* [Azure Architectures](https://learn.microsoft.com/en-us/azure/architecture/browse/&sa=D&source=editors&ust=1732701939599430&usg=AOvVaw1n4tTsIh86koMS4_uyQVP2)
