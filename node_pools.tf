# ==============================================================================
# Kakao Cloud Kubernetes Engine Module - Node Pools
# ==============================================================================
# Orchestrates multiple node pools using for_each.

module "node_pool" {
  source   = "./modules/node-pool"
  for_each = var.create ? local.node_pools : {}

  create = try(each.value.create, true)

  cluster_name = module.cluster.cluster_name

  name               = each.key
  description        = each.value.description
  kubernetes_version = each.value.kubernetes_version
  minor_version      = each.value.minor_version

  # Node configuration
  node_count         = each.value.node_count
  node_flavor        = each.value.node_flavor
  is_gpu             = each.value.is_gpu
  image_id           = each.value.image_id
  ssh_key_name       = each.value.ssh_key_name
  volume_size        = each.value.volume_size
  is_hyper_threading = each.value.is_hyper_threading
  user_data          = each.value.user_data

  # Network
  vpc_id             = each.value.vpc_id
  subnet_ids         = each.value.subnet_ids
  security_group_ids = each.value.security_group_ids

  # Kubernetes config
  labels = each.value.labels
  taints = each.value.taints

  # Auto-scaling
  auto_scaling = each.value.auto_scaling

  # Timeouts
  timeouts = each.value.timeouts

  depends_on = [module.cluster]
}
