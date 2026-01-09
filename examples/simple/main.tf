# ==============================================================================
# Simple Example - Single Cluster with Default Node Pool
# ==============================================================================

module "ke" {
  source = "../../"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  node_pools = {
    default = {
      node_count   = var.node_count
      node_flavor  = var.node_flavor
      ssh_key_name = var.ssh_key_name
    }
  }

  tags = var.tags
}
