# ==============================================================================
# Kubernetes Engine Node Pool Submodule - Outputs
# ==============================================================================

output "node_pool_id" {
  description = "The ID of the node pool."
  value       = try(kakaocloud_kubernetes_engine_node_pool.this[0].id, null)
}

output "node_pool_name" {
  description = "The name of the node pool."
  value       = try(kakaocloud_kubernetes_engine_node_pool.this[0].name, null)
}

output "node_count" {
  description = "The current node count."
  value       = try(kakaocloud_kubernetes_engine_node_pool.this[0].node_count, null)
}

output "flavor_id" {
  description = "The flavor ID of the nodes."
  value       = try(kakaocloud_kubernetes_engine_node_pool.this[0].flavor_id, null)
}

output "image_id" {
  description = "The image ID of the nodes."
  value       = try(kakaocloud_kubernetes_engine_node_pool.this[0].image_id, null)
}

output "auto_scaling_enabled" {
  description = "Whether auto-scaling is enabled."
  value       = local.auto_scaling_enabled
}

output "status" {
  description = "The status of the node pool."
  value       = try(kakaocloud_kubernetes_engine_node_pool.this[0].status, null)
}

output "is_gpu" {
  description = "Whether this is a GPU node pool."
  value       = try(kakaocloud_kubernetes_engine_node_pool.this[0].is_gpu, null)
}

output "is_upgradable" {
  description = "Whether the node pool is upgradable."
  value       = try(kakaocloud_kubernetes_engine_node_pool.this[0].is_upgradable, null)
}

output "created_at" {
  description = "The creation timestamp."
  value       = try(kakaocloud_kubernetes_engine_node_pool.this[0].created_at, null)
}
