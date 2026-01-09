# ==============================================================================
# Kakao Cloud Kubernetes Engine Module - Outputs
# ==============================================================================

# ------------------------------------------------------------------------------
# Cluster Outputs
# ------------------------------------------------------------------------------

output "cluster_id" {
  description = "The ID of the Kubernetes Engine cluster."
  value       = module.cluster.cluster_id
}

output "cluster_name" {
  description = "The name of the Kubernetes Engine cluster."
  value       = module.cluster.cluster_name
}

output "cluster_status" {
  description = "The status of the cluster."
  value       = module.cluster.cluster_status
}

output "cluster_version" {
  description = "The Kubernetes version of the cluster."
  value       = module.cluster.kubernetes_version
}

output "control_plane_endpoint" {
  description = "The control plane endpoint object (host, port)."
  value       = module.cluster.control_plane_endpoint
}

output "control_plane_host" {
  description = "The control plane host address."
  value       = module.cluster.control_plane_host
}

output "control_plane_port" {
  description = "The control plane port."
  value       = module.cluster.control_plane_port
}

output "cluster_api_version" {
  description = "The API version of the cluster."
  value       = module.cluster.api_version
}

output "cluster_is_upgradable" {
  description = "Whether the cluster can be upgraded."
  value       = module.cluster.is_upgradable
}

output "cluster_created_at" {
  description = "The cluster creation timestamp."
  value       = module.cluster.created_at
}

output "cluster_network" {
  description = "The cluster network configuration."
  value       = module.cluster.network
}

output "cluster_vpc_info" {
  description = "The cluster VPC information."
  value       = module.cluster.vpc_info
}

# ------------------------------------------------------------------------------
# Kubeconfig Outputs
# ------------------------------------------------------------------------------

output "kubeconfig" {
  description = "The full kubeconfig data source object."
  value       = module.cluster.kubeconfig
  sensitive   = true
}

output "kubeconfig_yaml" {
  description = "The kubeconfig in YAML format (ready to use with kubectl)."
  value       = module.cluster.kubeconfig_yaml
  sensitive   = true
}

output "kubeconfig_api_server" {
  description = "The Kubernetes API server URL."
  value       = module.cluster.kubeconfig_api_server
}

output "kubeconfig_ca_data" {
  description = "The base64-encoded CA certificate."
  value       = module.cluster.kubeconfig_ca_data
  sensitive   = true
}

output "kubeconfig_current_context" {
  description = "The current context name from kubeconfig."
  value       = module.cluster.kubeconfig_current_context
}

# ------------------------------------------------------------------------------
# Node Pool Outputs
# ------------------------------------------------------------------------------

output "node_pools" {
  description = "Map of node pool configurations and attributes."
  value = {
    for name, pool in module.node_pool : name => {
      id                   = pool.node_pool_id
      name                 = pool.node_pool_name
      node_count           = pool.node_count
      flavor_id            = pool.flavor_id
      image_id             = pool.image_id
      is_gpu               = pool.is_gpu
      is_upgradable        = pool.is_upgradable
      auto_scaling_enabled = pool.auto_scaling_enabled
      status               = pool.status
      created_at           = pool.created_at
    }
  }
}

output "node_pool_ids" {
  description = "Map of node pool names to their IDs."
  value       = { for name, pool in module.node_pool : name => pool.node_pool_id }
}

output "node_pool_names" {
  description = "List of all node pool names."
  value       = keys(module.node_pool)
}

# ------------------------------------------------------------------------------
# Scheduled Scaling Outputs
# ------------------------------------------------------------------------------

output "scheduled_scaling_rules" {
  description = "Map of scheduled scaling rule configurations."
  value = {
    for key, rule in module.scheduled_scaling : key => {
      id             = rule.rule_id
      name           = rule.rule_name
      node_pool_name = rule.node_pool_name
      schedule_type  = rule.schedule_type
      desired_nodes  = rule.desired_nodes
    }
  }
}

# ------------------------------------------------------------------------------
# Summary Output
# ------------------------------------------------------------------------------

output "cluster_summary" {
  description = "Complete cluster summary as a structured object."
  value = {
    cluster = {
      id                     = module.cluster.cluster_id
      name                   = module.cluster.cluster_name
      status                 = module.cluster.cluster_status
      version                = module.cluster.kubernetes_version
      control_plane_endpoint = module.cluster.control_plane_endpoint
      api_server             = module.cluster.kubeconfig_api_server
      is_upgradable          = module.cluster.is_upgradable
      created_at             = module.cluster.created_at
    }
    node_pools = {
      for name, pool in module.node_pool : name => {
        id                   = pool.node_pool_id
        name                 = pool.node_pool_name
        node_count           = pool.node_count
        is_gpu               = pool.is_gpu
        auto_scaling_enabled = pool.auto_scaling_enabled
        status               = pool.status
      }
    }
    scheduled_scaling_rules = {
      for key, rule in module.scheduled_scaling : key => {
        id        = rule.rule_id
        pool_name = rule.node_pool_name
      }
    }
  }
}
