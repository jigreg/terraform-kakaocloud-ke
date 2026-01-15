# ==============================================================================
# Kubernetes Engine Node Pool Submodule - Variables
# ==============================================================================
# Reference: https://registry.terraform.io/providers/kakaoenterprise/kakaocloud/latest/docs/resources/kubernetes_engine_node_pool

variable "create" {
  description = "Controls whether to create the node pool."
  type        = bool
  default     = true
}

# ------------------------------------------------------------------------------
# Required Arguments
# ------------------------------------------------------------------------------

variable "cluster_name" {
  description = "Name of the cluster this node pool belongs to."
  type        = string
}

variable "name" {
  description = "Name of the node pool."
  type        = string
}

variable "node_flavor" {
  description = "Instance flavor for worker nodes (e.g., m2a.large). Used to lookup flavor_id."
  type        = string
  default     = "m2a.large"
}

variable "ssh_key_name" {
  description = "SSH key name to inject into nodes."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the node pool."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the node pool."
  type        = list(string)
}

# ------------------------------------------------------------------------------
# Image Configuration
# ------------------------------------------------------------------------------

variable "kubernetes_version" {
  description = "Kubernetes version for node pool image selection."
  type        = string
  default     = "1.30"
}

variable "is_gpu" {
  description = "Whether this is a GPU node pool (for image selection)."
  type        = bool
  default     = false
}

variable "image_id" {
  description = "Override the auto-detected image ID."
  type        = string
  default     = null
}

# ------------------------------------------------------------------------------
# Optional Arguments
# ------------------------------------------------------------------------------

variable "description" {
  description = "Description of the node pool."
  type        = string
  default     = ""
}

variable "node_count" {
  description = "Desired number of nodes in the pool (request_node_count)."
  type        = number
  default     = 2
}

variable "minor_version" {
  description = "Kubernetes minor version of the node pool."
  type        = string
  default     = null
}

variable "volume_size" {
  description = "Root volume size in GiB. Required for VM or GPU node pools."
  type        = number
  default     = "50"
}

variable "is_hyper_threading" {
  description = "Whether hyper-threading is enabled. true: 2 vCPUs per physical core, false: vCPUs equal to physical cores."
  type        = bool
  default     = true
}

variable "user_data" {
  description = "User script to run when creating nodes (base64 encoded, up to 16KB)."
  type        = string
  default     = null
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
  description = "Kubernetes labels to apply to nodes (key/value pairs)."
  type        = map(string)
  default     = {}
}

variable "taints" {
  description = "Kubernetes taints to apply to nodes."
  type = list(object({
    key    = string
    value  = optional(string, "")
    effect = string # NoExecute, NoSchedule, PreferNoSchedule
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
    scale_down_threshold            = optional(number, 50) # Percentage (0-100), converted to ratio
    threshold_duration_minutes      = optional(number, 10) # Converted to seconds
    post_scale_up_exclusion_minutes = optional(number, 10) # Converted to seconds
  })
  default = null
}

# ------------------------------------------------------------------------------
# Timeouts Configuration
# ------------------------------------------------------------------------------

variable "timeouts" {
  description = "Custom timeout settings for create, read, update, delete operations."
  type = object({
    create = optional(string, "30m")
    read   = optional(string, "5m")
    update = optional(string, "10m")
    delete = optional(string, "5m")
  })
  default = null
}
