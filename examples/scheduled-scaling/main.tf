# ==============================================================================
# Scheduled Scaling Example
# ==============================================================================
# Demonstrates time-based scheduled scaling for cost optimization.
# schedule_type: "cron" (periodic via CRON) or "once" (single execution)

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
    # Web tier - scales based on CRON schedule
    web = {
      node_count  = 3
      node_flavor = "m2a.large"
      labels = {
        "tier" = "web"
      }

      # Scale up during business hours (weekdays 9am-6pm KST = 0am-9am UTC)
      scheduled_scaling = [
        {
          name          = "business-hours-scaleup"
          desired_nodes = 10
          schedule_type = "cron"
          start_time    = "2025-01-01T00:00:00Z"
          schedule      = "0 0 * * 1-5"  # Weekdays at midnight UTC (9am KST)
        },
        {
          name          = "evening-scaledown"
          desired_nodes = 2
          schedule_type = "cron"
          start_time    = "2025-01-01T00:00:00Z"
          schedule      = "0 9 * * 1-5"  # Weekdays at 9am UTC (6pm KST)
        }
      ]
    }

    # Batch processing - one-time scale for a specific job
    batch = {
      node_count  = 1
      node_flavor = "m2a.xlarge"
      labels = {
        "tier" = "batch"
      }
      taints = [{
        key    = "dedicated"
        value  = "batch"
        effect = "NoSchedule"
      }]

      # One-time scale up for a scheduled batch job
      scheduled_scaling = [
        {
          name          = "batch-job-scaleup"
          desired_nodes = 5
          schedule_type = "once"
          start_time    = "2025-02-01T02:00:00Z"
        }
      ]
    }
  }
}
