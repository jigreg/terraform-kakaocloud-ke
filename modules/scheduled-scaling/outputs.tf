# ==============================================================================
# Kubernetes Engine Scheduled Scaling Submodule - Outputs
# ==============================================================================

output "rule_id" {
  description = "The name of the scheduled scaling rule (used as identifier)."
  value       = var.create ? var.name : null
}

output "rule_name" {
  description = "The name of the scheduled scaling rule."
  value       = var.create ? var.name : null
}

output "node_pool_name" {
  description = "The name of the node pool this rule applies to."
  value       = var.node_pool_name
}

output "schedule_type" {
  description = "The schedule type (cron or once)."
  value       = var.schedule_type
}

output "desired_nodes" {
  description = "The target number of nodes."
  value       = var.desired_nodes
}

output "created_at" {
  description = "The creation timestamp."
  value       = try(kakaocloud_kubernetes_engine_scheduled_scaling.this[0].created_at, null)
}
