# ==============================================================================
# Multiple Node Pools Example - Outputs
# ==============================================================================

output "cluster_summary" {
  description = "Complete cluster summary."
  value       = module.ke.cluster_summary
}

output "node_pools" {
  description = "All node pools information."
  value       = module.ke.node_pools
}
