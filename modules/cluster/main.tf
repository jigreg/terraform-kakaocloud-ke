# ==============================================================================
# Kubernetes Engine Cluster Submodule
# ==============================================================================
# Creates a Kakao Cloud Kubernetes Engine cluster.
# Reference: https://registry.terraform.io/providers/kakaoenterprise/kakaocloud/latest/docs/resources/kubernetes_engine_cluster

locals {
  # Convert subnet IDs to object list expected by provider
  subnet_list = [for subnet_id in var.subnet_ids : { id = subnet_id }]
}

resource "kakaocloud_kubernetes_engine_cluster" "this" {
  count = var.create ? 1 : 0

  name            = var.name
  description     = var.description
  is_allocate_fip = var.is_allocate_fip

  # Kubernetes version
  version = {
    minor_version = var.kubernetes_version
  }

  # Networking
  network = {
    cni          = var.cni
    pod_cidr     = var.pod_cidr
    service_cidr = var.service_cidr
  }

  # Existing VPC/Subnets
  vpc_info = {
    id      = var.vpc_id
    subnets = local.subnet_list
  }

  lifecycle {
    create_before_destroy = false
  }
}

data "kakaocloud_kubernetes_engine_kubeconfig" "this" {
  count = var.create ? 1 : 0

  cluster_name = kakaocloud_kubernetes_engine_cluster.this[0].name

  depends_on = [kakaocloud_kubernetes_engine_cluster.this]
}
