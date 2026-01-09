# ==============================================================================
# Kubernetes Engine Node Pool Submodule
# ==============================================================================
# Creates a Kakao Cloud Kubernetes Engine node pool with optional auto-scaling.
# Reference: https://registry.terraform.io/providers/kakaoenterprise/kakaocloud/latest/docs/resources/kubernetes_engine_node_pool

locals {
  # Convert subnet IDs to the object list expected by the provider
  subnet_list = [for subnet_id in var.subnet_ids : { id = subnet_id }]

  # Determine if auto-scaling is enabled
  auto_scaling_enabled = try(var.auto_scaling.enabled, false)

  # Convert labels map to set of objects
  labels_list = length(var.labels) > 0 ? [
    for k, v in var.labels : {
      key   = k
      value = v
    }
  ] : null

  # Convert taints to set of objects
  taints_list = length(var.taints) > 0 ? [
    for t in var.taints : {
      key    = t.key
      value  = t.value
      effect = t.effect
    }
  ] : null
}

# ------------------------------------------------------------------------------
# Data Sources for Image and Flavor
# ------------------------------------------------------------------------------

data "kakaocloud_instance_flavors" "node" {
  count = var.create ? 1 : 0

  filter = [
    {
      name  = "instance_type"
      value = "vm"
    },
    {
      name  = "name"
      value = var.node_flavor
    }
  ]
}

data "kakaocloud_kubernetes_engine_images" "node" {
  count = var.create ? 1 : 0

  filter = [
    {
      name  = "instance_type"
      value = "vm"
    },
    {
      name  = "k8s_version"
      value = var.kubernetes_version
    },
    {
      name  = "is_gpu_type"
      value = var.is_gpu
    }
  ]
}

# ------------------------------------------------------------------------------
# Node Pool Resource
# ------------------------------------------------------------------------------

resource "kakaocloud_kubernetes_engine_node_pool" "this" {
  count = var.create ? 1 : 0

  # Required arguments
  name         = var.name
  cluster_name = var.cluster_name
  image_id     = coalesce(var.image_id, data.kakaocloud_kubernetes_engine_images.node[0].images[0].id)
  flavor_id    = data.kakaocloud_instance_flavors.node[0].instance_flavors[0].id
  ssh_key_name = var.ssh_key_name

  vpc_info = {
    id      = var.vpc_id
    subnets = local.subnet_list
  }

  # Optional arguments
  description = var.description
  volume_size = var.volume_size

  # Node count - only set if autoscaling is disabled
  request_node_count = local.auto_scaling_enabled ? null : var.node_count

  # Security groups (optional)
  request_security_groups = length(var.security_group_ids) > 0 ? var.security_group_ids : null

  # User data script (optional, base64 encoded)
  user_data = var.user_script

  # Node labels (set of objects)
  labels = local.labels_list

  # Node taints (set of objects)
  taints = local.taints_list

  # Auto-scaling configuration (object, not block)
  autoscaling = local.auto_scaling_enabled ? {
    is_autoscaler_enable              = true
    autoscaler_min_node_count         = var.auto_scaling.min_nodes
    autoscaler_max_node_count         = var.auto_scaling.max_nodes
    autoscaler_desired_node_count     = var.node_count
    autoscaler_scale_down_threshold   = var.auto_scaling.scale_down_threshold / 100.0
    autoscaler_scale_down_unneeded_time = var.auto_scaling.threshold_duration_minutes * 60
    autoscaler_scale_down_unready_time  = var.auto_scaling.post_scale_up_exclusion_minutes * 60
  } : null

  lifecycle {
    create_before_destroy = false
  }
}
