# ==============================================================================
# Kakao Cloud Kubernetes Engine Module
# ==============================================================================
# A reusable Terraform module for creating Kakao Cloud Kubernetes Engine
# clusters with multiple node pools and scheduled scaling support.
# Reference: https://registry.terraform.io/providers/kakaoenterprise/kakaocloud/latest/docs

# ------------------------------------------------------------------------------
# Cluster
# ------------------------------------------------------------------------------

module "cluster" {
  source = "./modules/cluster"

  create = var.create

  name               = var.cluster_name
  description        = var.cluster_description
  kubernetes_version = var.cluster_version
  is_allocate_fip    = var.is_allocate_fip

  # Network configuration
  vpc_id       = var.vpc_id
  subnet_ids   = var.subnet_ids
  cni          = var.network_config.cni
  pod_cidr     = var.network_config.pod_cidr
  service_cidr = var.network_config.service_cidr
}
