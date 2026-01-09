# ==============================================================================
# Kubernetes Engine Cluster Submodule - Outputs
# ==============================================================================

# ------------------------------------------------------------------------------
# Cluster Resource Outputs
# ------------------------------------------------------------------------------

output "cluster_id" {
  description = "The ID of the Kubernetes Engine cluster."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].id, null)
}

output "cluster_name" {
  description = "The name of the Kubernetes Engine cluster."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].name, null)
}

output "cluster_status" {
  description = "The status of the cluster (Pending, Provisioning, Provisioned, Updating, Deleting, Failed)."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].status, null)
}

output "kubernetes_version" {
  description = "The Kubernetes version of the cluster."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].version, null)
}

output "control_plane_endpoint" {
  description = "The control plane endpoint object (host, port)."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].control_plane_endpoint, null)
}

output "control_plane_host" {
  description = "The control plane host address."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].control_plane_endpoint.host, null)
}

output "control_plane_port" {
  description = "The control plane port."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].control_plane_endpoint.port, null)
}

output "api_version" {
  description = "The API version of the cluster."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].api_version, null)
}

output "is_upgradable" {
  description = "Whether the cluster can be upgraded."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].is_upgradable, null)
}

output "created_at" {
  description = "The creation timestamp (ISO 8601, UTC)."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].created_at, null)
}

output "failure_message" {
  description = "Error details if the cluster is in Failed status."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].failure_message, null)
}

output "creator_info" {
  description = "Creator information (id, name)."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].creator_info, null)
}

output "network" {
  description = "Network configuration (cni, pod_cidr, service_cidr)."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].network, null)
}

output "vpc_info" {
  description = "VPC information."
  value       = try(kakaocloud_kubernetes_engine_cluster.this[0].vpc_info, null)
}

# ------------------------------------------------------------------------------
# Kubeconfig Data Source Outputs
# ------------------------------------------------------------------------------

output "kubeconfig" {
  description = "The full kubeconfig data source object."
  value       = try(data.kakaocloud_kubernetes_engine_kubeconfig.this[0], null)
  sensitive   = true
}

output "kubeconfig_yaml" {
  description = "The kubeconfig in YAML format."
  value       = try(data.kakaocloud_kubernetes_engine_kubeconfig.this[0].kubeconfig_yaml, null)
  sensitive   = true
}

output "kubeconfig_api_server" {
  description = "The Kubernetes API server URL from kubeconfig."
  value       = try(data.kakaocloud_kubernetes_engine_kubeconfig.this[0].clusters[0].cluster.server, null)
}

output "kubeconfig_ca_data" {
  description = "The base64-encoded CA certificate from kubeconfig."
  value       = try(data.kakaocloud_kubernetes_engine_kubeconfig.this[0].clusters[0].cluster.certificate_authority_data, null)
  sensitive   = true
}

output "kubeconfig_current_context" {
  description = "The current context name from kubeconfig."
  value       = try(data.kakaocloud_kubernetes_engine_kubeconfig.this[0].current_context, null)
}
