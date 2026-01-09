# ==============================================================================
# Kakao Cloud Kubernetes Engine Module - Scheduled Scaling
# ==============================================================================
# Orchestrates scheduled scaling rules for node pools.
# schedule_type: "cron" (periodic via CRON) or "once" (single execution)

module "scheduled_scaling" {
  source   = "./modules/scheduled-scaling"
  for_each = var.create ? local.scheduled_scaling_map : {}

  cluster_name   = module.cluster.cluster_name
  node_pool_name = module.node_pool[each.value.pool_name].node_pool_name

  name          = each.value.rule.name
  desired_nodes = each.value.rule.desired_nodes
  schedule_type = each.value.rule.schedule_type
  start_time    = each.value.rule.start_time
  schedule      = each.value.rule.schedule

  depends_on = [module.node_pool]
}
