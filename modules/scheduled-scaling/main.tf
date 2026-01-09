# ==============================================================================
# Kubernetes Engine Scheduled Scaling Submodule
# ==============================================================================
# Creates scheduled scaling rules for Kakao Cloud Kubernetes Engine node pools.
# Reference: https://registry.terraform.io/providers/kakaoenterprise/kakaocloud/latest/docs/resources/kubernetes_engine_scheduled_scaling
#
# schedule_type: "cron" (periodic via CRON) or "once" (single execution)

resource "kakaocloud_kubernetes_engine_scheduled_scaling" "this" {
  count = var.create ? 1 : 0

  # Required arguments
  cluster_name   = var.cluster_name
  node_pool_name = var.node_pool_name
  name           = var.name
  desired_nodes  = var.desired_nodes
  schedule_type  = var.schedule_type
  start_time     = var.start_time

  # Optional: CRON schedule for periodic execution
  schedule = var.schedule
}
