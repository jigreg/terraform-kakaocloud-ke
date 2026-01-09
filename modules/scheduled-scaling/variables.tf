# ==============================================================================
# Kubernetes Engine Scheduled Scaling Submodule - Variables
# ==============================================================================

variable "create" {
  description = "Controls whether to create the scheduled scaling rule."
  type        = bool
  default     = true
}

variable "cluster_name" {
  description = "Target cluster name."
  type        = string
}

variable "node_pool_name" {
  description = "Target node pool name."
  type        = string
}

variable "name" {
  description = "Scheduled autoscaling rule name."
  type        = string
}

# ------------------------------------------------------------------------------
# Scaling Configuration
# ------------------------------------------------------------------------------

variable "desired_nodes" {
  description = "Target number of nodes to maintain in the node pool."
  type        = number
}

variable "schedule_type" {
  description = "Schedule type: 'cron' (periodic via CRON) or 'once' (single execution)."
  type        = string

  validation {
    condition     = contains(["cron", "once"], var.schedule_type)
    error_message = "Schedule type must be 'cron' or 'once'."
  }
}

variable "start_time" {
  description = "Reference time when scheduled autoscaling can run (ISO 8601, UTC). Example: '2025-01-15T09:00:00Z'"
  type        = string
}

variable "schedule" {
  description = "CRON expression for periodic execution (required when schedule_type is 'cron'). Example: '0 9 * * 1-5' for weekdays at 9am."
  type        = string
  default     = null
}
