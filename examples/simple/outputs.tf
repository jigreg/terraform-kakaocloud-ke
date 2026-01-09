# ==============================================================================
# Simple Example - Outputs
# ==============================================================================

output "cluster_id" {
  description = "Cluster ID."
  value       = module.ke.cluster_id
}

output "cluster_name" {
  description = "Cluster name."
  value       = module.ke.cluster_name
}

output "control_plane_endpoint" {
  description = "Control plane endpoint."
  value       = module.ke.control_plane_endpoint
}

output "node_pools" {
  description = "Node pools information."
  value       = module.ke.node_pools
}
