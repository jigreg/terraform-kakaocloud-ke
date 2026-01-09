# ==============================================================================
# Kakao Cloud Kubernetes Engine Module - Variables
# ==============================================================================
# Main interface for the reusable KE module.
# Reference: https://registry.terraform.io/providers/kakaoenterprise/kakaocloud/latest/

# ------------------------------------------------------------------------------
# Module Control
# ------------------------------------------------------------------------------

variable "create" {
  description = "Controls whether to create the cluster and related resources."
  type        = bool
  default     = true
}

# ------------------------------------------------------------------------------
# Cluster Configuration
# ------------------------------------------------------------------------------

variable "cluster_name" {
  description = "Name of the Kubernetes Engine cluster (4-20 characters)."
  type        = string

  validation {
    condition     = length(var.cluster_name) >= 4 && length(var.cluster_name) <= 20
    error_message = "Cluster name must be between 4 and 20 characters."
  }
}

variable "cluster_description" {
  description = "Description of the cluster."
  type        = string
  default     = ""
}

variable "cluster_version" {
  description = "Kubernetes minor version for the control plane (e.g., '1.29', '1.30')."
  type        = string
  default     = "1.29"
}

variable "is_allocate_fip" {
  description = "Whether to allocate a floating IP to the control plane."
  type        = bool
  default     = true
}

# ------------------------------------------------------------------------------
# Network Configuration
# ------------------------------------------------------------------------------

variable "vpc_id" {
  description = "ID of the existing VPC for the cluster."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the cluster (spread across at least 2 AZs)."
  type        = list(string)
}

variable "network_config" {
  description = "Network configuration for the cluster."
  type = object({
    cni          = optional(string, "cilium")
    pod_cidr     = optional(string, "172.16.0.0/16")
    service_cidr = optional(string, "172.17.0.0/16")
  })
  default = {}

  validation {
    condition     = contains(["cilium", "calico"], try(var.network_config.cni, "cilium"))
    error_message = "CNI must be one of: cilium, calico."
  }
}

# ------------------------------------------------------------------------------
# Node Pools Configuration (Map of Objects Pattern)
# ------------------------------------------------------------------------------

variable "node_pools" {
  description = <<-EOT
    Map of node pool configurations. Each key is the node pool name.

    Example:
    node_pools = {
      default = {
        node_count  = 2
        node_flavor = "m2a.large"
      }
      gpu = {
        node_count  = 1
        node_flavor = "g2a.xlarge"
        is_gpu      = true
        labels      = { "nvidia.com/gpu" = "true" }
        taints = [{
          key    = "nvidia.com/gpu"
          value  = "true"
          effect = "NoSchedule"
        }]
      }
    }
  EOT

  type = map(object({
    # Basic configuration
    node_count     = optional(number, 2)
    min_node_count = optional(number, null)
    max_node_count = optional(number, null)
    node_flavor    = optional(string, "m2a.large")
    description    = optional(string, "")

    # Image configuration
    kubernetes_version = optional(string, null)
    is_gpu             = optional(bool, false)
    image_id           = optional(string, null)

    # Network configuration
    vpc_id             = optional(string, null)
    subnet_ids         = optional(list(string), null)
    security_group_ids = optional(list(string), [])

    # Node configuration
    ssh_key_name = optional(string, null)
    user_script  = optional(string, null)
    volume_size  = optional(number, null)

    # Kubernetes configuration
    labels = optional(map(string), {})
    taints = optional(list(object({
      key    = string
      value  = optional(string, "")
      effect = string
    })), [])

    # Auto-scaling configuration
    auto_scaling = optional(object({
      enabled                         = optional(bool, false)
      min_nodes                       = optional(number, 1)
      max_nodes                       = optional(number, 10)
      scale_down_threshold            = optional(number, 50)
      threshold_duration_minutes      = optional(number, 10)
      post_scale_up_exclusion_minutes = optional(number, 10)
    }), null)

    # Scheduled scaling rules
    # schedule_type: "cron" (periodic) or "once" (single execution)
    scheduled_scaling = optional(list(object({
      name          = string
      desired_nodes = number
      schedule_type = string
      start_time    = string
      schedule      = optional(string, null)
    })), [])

    # Lifecycle
    create = optional(bool, true)
  }))

  default = {}
}

# ------------------------------------------------------------------------------
# Node Pool Defaults (Applied to All Pools Unless Overridden)
# ------------------------------------------------------------------------------

variable "node_pool_defaults" {
  description = "Default values applied to all node pools (can be overridden per pool)."
  type = object({
    node_count   = optional(number, 2)
    node_flavor  = optional(string, "m2a.large")
    ssh_key_name = optional(string, null)
    volume_size  = optional(number, null)
    labels       = optional(map(string), {})
    taints = optional(list(object({
      key    = string
      value  = optional(string, "")
      effect = string
    })), [])
  })
  default = {}
}

