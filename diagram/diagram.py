#!/usr/bin/env python
# pyright: reportUnusedExpression=false

from diagrams import Diagram, Cluster, Edge

from diagrams.gcp.compute import ComputeEngine, KubernetesEngine
from diagrams.gcp.database import SQL
from diagrams.gcp.operations import Monitoring
from diagrams.gcp.storage import Storage
from diagrams.gcp.devtools import ContainerRegistry

from diagrams.onprem.compute import Server
from diagrams.onprem.container import Docker

from diagrams.k8s.compute import Pod
from diagrams.k8s.clusterconfig import HorizontalPodAutoscaler
from diagrams.k8s.network import Service
from diagrams.k8s.storage import Vol

with Diagram("Capstone Project", "capstone", direction="LR", outformat="png", show=False):
    init_server = Server("My PC")
    with Cluster("VPC"):
        with Cluster("Jenkins"):
            with Cluster("Jenkins nodes"):
                jenkins_nodes = ComputeEngine("Jenkins slave\nnode")
            jenkins_master = ComputeEngine("Jenkins master\nnode")
        with Cluster("App deployment"):
            with Cluster("Workload"):
                with Cluster("Deployment"):
                    with Cluster("Containers"):
                        spring_petclinic = Docker("spring-petclinic")
                        cloud_sql_proxy = Docker("cloud-sql-proxy")
                        volume = Vol("Service account")
                    pod = Pod("Spring Petclinic")
                hpa = HorizontalPodAutoscaler("Horizontal\nPod Autoscaler")
                lb = Service("Load Balancer")
            gke_cluster = KubernetesEngine("GKE autopilot\ncluster")
        artifact_registry = ContainerRegistry("Spring-Petclinic\ndocker images")
        mysql = SQL("Cloud SQL")
    with Cluster("Terraform remote state"):
        tf_state_jenkins = Storage("Jenkins deployment\nbucket")
        tf_state_infrastructure = Storage("App infrastructure\ndeployment bucket")
        tf_state_app = Storage("App deployment\nbucket")
    monitor = Monitoring("Monitoring dashboard")

    init_server >> jenkins_master >> jenkins_nodes
    init_server >> Edge() << tf_state_jenkins
    init_server >> tf_state_infrastructure
    init_server >> tf_state_app
    init_server >> monitor

    jenkins_nodes >> gke_cluster
    jenkins_nodes >> artifact_registry
    jenkins_nodes >> Edge() << tf_state_infrastructure
    jenkins_nodes >> Edge() << tf_state_app

    gke_cluster >> pod
    gke_cluster >> hpa
    gke_cluster >> lb

    pod >> spring_petclinic
    pod >> cloud_sql_proxy

    cloud_sql_proxy - volume
    cloud_sql_proxy >> Edge() << mysql
    spring_petclinic << artifact_registry
    spring_petclinic >> Edge() << cloud_sql_proxy
