# ==============================================================================
# Auto-Scaling Example
# ==============================================================================
# Demonstrates resource-based auto-scaling for node pools.

module "ke" {
  source = "../../"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  node_pool_defaults = {
    ssh_key_name = var.ssh_key_name
  }

  node_pools = {
    # System pool - fixed size for critical workloads
    system = {
      node_count  = 2
      node_flavor = "m2a.large"
      labels = {
        "pool-type" = "system"
      }
    }

    # Application pool - auto-scaling enabled
    app = {
      node_count  = 3
      node_flavor = "m2a.xlarge"
      labels = {
        "pool-type" = "app"
      }
      auto_scaling = {
        enabled                          = true
        min_nodes                        = 2
        max_nodes                        = 10
        scale_down_threshold             = 50
        threshold_duration_minutes       = 10
        post_scale_up_exclusion_minutes  = 5
      }
    }
  }

  tags = var.tags
}
