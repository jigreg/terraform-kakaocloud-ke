# ==============================================================================
# Kubernetes Engine Node Pool Submodule - Variables
# ==============================================================================

variable "create" {
  description = "Controls whether to create the node pool."
  type        = bool
  default     = true
}

variable "cluster_name" {
  description = "Name of the cluster this node pool belongs to."
  type        = string
}

variable "name" {
  description = "Name of the node pool."
  type        = string
}

variable "description" {
  description = "Description of the node pool."
  type        = string
  default     = ""
}

# ------------------------------------------------------------------------------
# Node Configuration
# ------------------------------------------------------------------------------

variable "node_count" {
  description = "Desired number of nodes in the pool."
  type        = number
  default     = 2
}

variable "node_flavor" {
  description = "Instance flavor for worker nodes (e.g., m2a.large)."
  type        = string
  default     = "m2a.large"
}

variable "kubernetes_version" {
  description = "Kubernetes version for node pool image selection."
  type        = string
  default     = "1.29"
}

variable "is_gpu" {
  description = "Whether this is a GPU node pool."
  type        = bool
  default     = false
}

variable "image_id" {
  description = "Override the auto-detected image ID."
  type        = string
  default     = null
}

variable "ssh_key_name" {
  description = "SSH KeyPair name to inject into nodes."
  type        = string
  default     = null
}

variable "user_script" {
  description = "User script to run on node initialization (base64 encoded, up to 16KB)."
  type        = string
  default     = null
}

variable "volume_size" {
  description = "Volume size in GB (30-16384, SSD only)."
  type        = number
  default     = null
}

# ------------------------------------------------------------------------------
# Network Configuration
# ------------------------------------------------------------------------------

variable "vpc_id" {
  description = "VPC ID for the node pool."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the node pool."
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to nodes."
  type        = list(string)
  default     = []
}

# ------------------------------------------------------------------------------
# Kubernetes Configuration
# ------------------------------------------------------------------------------

variable "labels" {
  description = "Kubernetes labels to apply to nodes."
  type        = map(string)
  default     = {}
}

variable "taints" {
  description = "Kubernetes taints to apply to nodes."
  type = list(object({
    key    = string
    value  = optional(string, "")
    effect = string
  }))
  default = []
}

# ------------------------------------------------------------------------------
# Auto-scaling Configuration
# ------------------------------------------------------------------------------

variable "auto_scaling" {
  description = "Resource-based auto-scaling configuration."
  type = object({
    enabled                         = optional(bool, false)
    min_nodes                       = optional(number, 1)
    max_nodes                       = optional(number, 10)
    scale_down_threshold            = optional(number, 50)
    threshold_duration_minutes      = optional(number, 10)
    post_scale_up_exclusion_minutes = optional(number, 10)
  })
  default = null
}
