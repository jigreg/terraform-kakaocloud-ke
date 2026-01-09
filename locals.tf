# ==============================================================================
# Kakao Cloud Kubernetes Engine Module - Locals
# ==============================================================================
# Computed values and transformations for the module.

locals {
  # Convert subnet IDs to object list expected by provider
  subnet_list = [for subnet_id in var.subnet_ids : { id = subnet_id }]

  # Merge defaults with each node pool configuration
  node_pools = {
    for name, pool in var.node_pools : name => merge(
      {
        # Apply defaults
        node_count  = try(var.node_pool_defaults.node_count, 2)
        node_flavor = try(var.node_pool_defaults.node_flavor, "m2a.large")
      },
      pool,
      {
        # Ensure name is set
        name = name
        # Use cluster version if not specified
        kubernetes_version = coalesce(pool.kubernetes_version, var.cluster_version)
        # Use cluster VPC/subnets if not specified
        vpc_id     = coalesce(pool.vpc_id, var.vpc_id)
        subnet_ids = coalesce(pool.subnet_ids, var.subnet_ids)
        # Use pool ssh_key_name, or node_pool_defaults, or module-level ssh_key_name (required)
        ssh_key_name = coalesce(pool.ssh_key_name, try(var.node_pool_defaults.ssh_key_name, null), var.ssh_key_name)
        # Use pool volume_size or defaults
        volume_size = pool.volume_size != null ? pool.volume_size : try(var.node_pool_defaults.volume_size, null)
        # Use pool is_hyper_threading or defaults
        is_hyper_threading = pool.is_hyper_threading != null ? pool.is_hyper_threading : try(var.node_pool_defaults.is_hyper_threading, null)
        # Use pool user_data or defaults
        user_data = pool.user_data != null ? pool.user_data : try(var.node_pool_defaults.user_data, null)
        # Use pool timeouts or defaults
        timeouts = pool.timeouts != null ? pool.timeouts : try(var.node_pool_defaults.timeouts, null)
        # Merge labels (pool labels override defaults)
        labels = merge(
          try(var.node_pool_defaults.labels, {}),
          try(pool.labels, {})
        )
        # Use pool taints or defaults
        taints = length(try(pool.taints, [])) > 0 ? pool.taints : try(var.node_pool_defaults.taints, [])
      }
    ) if try(pool.create, true)
  }

  # Flatten scheduled scaling rules across all node pools
  scheduled_scaling_rules = flatten([
    for pool_name, pool in local.node_pools : [
      for idx, rule in try(pool.scheduled_scaling, []) : {
        key       = "${pool_name}-${rule.name}"
        pool_name = pool_name
        rule      = rule
      }
    ]
  ])

  # Convert to map for for_each
  scheduled_scaling_map = {
    for item in local.scheduled_scaling_rules : item.key => item
  }
}
