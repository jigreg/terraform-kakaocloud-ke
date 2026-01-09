# ==============================================================================
# Scheduled Scaling Example - Outputs
# ==============================================================================

output "cluster_summary" {
  description = "Complete cluster summary."
  value       = module.ke.cluster_summary
}

output "node_pools" {
  description = "All node pools information."
  value       = module.ke.node_pools
}

output "scheduled_scaling_rules" {
  description = "Scheduled scaling rules."
  value       = module.ke.scheduled_scaling_rules
}
