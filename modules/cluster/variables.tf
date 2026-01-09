# ==============================================================================
# Kubernetes Engine Cluster Submodule - Variables
# ==============================================================================

variable "create" {
  description = "Controls whether to create the cluster."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the Kubernetes Engine cluster (4-20 characters)."
  type        = string
}

variable "description" {
  description = "Description of the cluster."
  type        = string
  default     = ""
}

variable "kubernetes_version" {
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
  description = "List of subnet IDs for the cluster."
  type        = list(string)
}

variable "cni" {
  description = "CNI plugin selection. Supported: cilium, calico."
  type        = string
  default     = "cilium"

  validation {
    condition     = contains(["cilium", "calico"], var.cni)
    error_message = "CNI must be one of: cilium, calico."
  }
}

variable "pod_cidr" {
  description = "CIDR block for Pod networks."
  type        = string
  default     = "172.16.0.0/16"
}

variable "service_cidr" {
  description = "CIDR block for Service networks."
  type        = string
  default     = "172.17.0.0/16"
}

