# ==============================================================================
# Multiple Node Pools Example
# ==============================================================================
# Demonstrates creating a cluster with multiple node pools for different workloads.

module "ke" {
  source = "../../"

  cluster_name        = var.cluster_name
  cluster_version     = var.cluster_version
  cluster_description = "Production cluster with multiple node pools"

  vpc_id       = var.vpc_id
  subnet_ids   = var.subnet_ids
  ssh_key_name = var.ssh_key_name

  network_config = {
    cni          = "cilium"
    pod_cidr     = "10.244.0.0/16"
    service_cidr = "10.245.0.0/16"
  }

  # Default settings for all pools
  node_pool_defaults = {
    volume_size = 100
    labels = {
      "managed-by" = "terraform"
    }
  }

  node_pools = {
    # General purpose workloads
    general = {
      node_count  = 3
      node_flavor = "m2a.xlarge"
      labels = {
        "workload-type" = "general"
      }
    }

    # Memory-intensive workloads
    memory = {
      node_count  = 2
      node_flavor = "r2a.xlarge"
      labels = {
        "workload-type" = "memory"
      }
      taints = [{
        key    = "workload-type"
        value  = "memory"
        effect = "NoSchedule"
      }]
    }

    # GPU workloads
    gpu = {
      node_count  = 1
      node_flavor = "g2a.xlarge"
      is_gpu      = true
      labels = {
        "nvidia.com/gpu" = "true"
        "workload-type"  = "gpu"
      }
      taints = [{
        key    = "nvidia.com/gpu"
        value  = "true"
        effect = "NoSchedule"
      }]
    }
  }
}
