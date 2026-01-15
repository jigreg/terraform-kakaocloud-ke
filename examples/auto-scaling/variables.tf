# ==============================================================================
# Auto-Scaling Example - Variables
# ==============================================================================

variable "cluster_name" {
  description = "Name of the cluster (4-20 characters)."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version."
  type        = string
  default     = "1.30"
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs."
  type        = list(string)
}

variable "ssh_key_name" {
  description = "SSH key name."
  type        = string
}

# Provider authentication
variable "application_credential_id" {
  description = "Kakao Cloud application credential ID."
  type        = string
  sensitive   = true
}

variable "application_credential_secret" {
  description = "Kakao Cloud application credential secret."
  type        = string
  sensitive   = true
}
