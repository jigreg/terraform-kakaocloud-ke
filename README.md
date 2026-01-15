# Kakao Cloud Kubernetes Engine Terraform Module

A reusable Terraform module for creating and managing Kakao Cloud Kubernetes Engine (KE) clusters.

## Features

- KE cluster creation and management
- Multiple node pools support (Map of Objects pattern)
- Node pool defaults configuration (`node_pool_defaults`)
- Resource-based auto-scaling
- Time-based scheduled scaling (cron/once)
- Automatic kubeconfig generation

## Usage

```hcl
module "ke" {
  source = "path/to/terraform-kakaocloud-ke"

  cluster_name    = "my-cluster"
  cluster_version = "1.30"

  vpc_id     = "vpc-xxxxxxxx"
  subnet_ids = ["subnet-aaaa", "subnet-bbbb"]

  node_pool_defaults = {
    ssh_key_name = "my-ssh-key"
  }

  node_pools = {
    default = {
      node_count  = 3
      node_flavor = "m2a.large"
    }
  }
}
```

## Examples

- [simple](./examples/simple) - Basic cluster configuration
- [multiple-node-pools](./examples/multiple-node-pools) - Multiple node pools configuration
- [auto-scaling](./examples/auto-scaling) - Auto-scaling configuration
- [scheduled-scaling](./examples/scheduled-scaling) - Scheduled scaling configuration

## Development

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.5.0
- [terraform-docs](https://github.com/terraform-docs/terraform-docs) (for documentation generation)

### Make Commands

| Command | Description |
|---------|-------------|
| `make docs` | Generate README.md for all modules |
| `make fmt` | Format Terraform files |
| `make validate` | Validate all modules |
| `make clean` | Clean .terraform cache |
| `make all` | Run fmt + docs + validate |

```bash
# Generate documentation
make docs

# Run all checks
make all
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_kakaocloud"></a> [kakaocloud](#requirement\_kakaocloud) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="requirement_kakaocloud"></a> [kakaocloud](#requirement\_kakaocloud) | >= 0.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster"></a> [cluster](#module\_cluster) | ./modules/cluster | n/a |
| <a name="module_node_pool"></a> [node\_pool](#module\_node\_pool) | ./modules/node-pool | n/a |
| <a name="module_scheduled_scaling"></a> [scheduled\_scaling](#module\_scheduled\_scaling) | ./modules/scheduled-scaling | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_description"></a> [cluster\_description](#input\_cluster\_description) | Description of the cluster. | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Kubernetes Engine cluster (4-20 characters). | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes minor version for the control plane (e.g., '1.30', '1.31'). | `string` | `"1.30"` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the cluster and related resources. | `bool` | `true` | no |
| <a name="input_is_allocate_fip"></a> [is\_allocate\_fip](#input\_is\_allocate\_fip) | Whether to allocate a floating IP to the control plane. | `bool` | `true` | no |
| <a name="input_network_config"></a> [network\_config](#input\_network\_config) | Network configuration for the cluster. | <pre>object({<br/>    cni          = optional(string, "cilium")<br/>    pod_cidr     = optional(string, "172.16.0.0/16")<br/>    service_cidr = optional(string, "172.17.0.0/16")<br/>  })</pre> | `{}` | no |
| <a name="input_node_pool_defaults"></a> [node\_pool\_defaults](#input\_node\_pool\_defaults) | Default values applied to all node pools (can be overridden per pool). | <pre>object({<br/>    node_count         = optional(number, 2)<br/>    node_flavor        = optional(string, "m2a.large")<br/>    ssh_key_name       = optional(string, null)<br/>    volume_size        = optional(number, null)<br/>    is_hyper_threading = optional(bool, null)<br/>    user_data          = optional(string, null)<br/>    labels             = optional(map(string), {})<br/>    taints = optional(list(object({<br/>      key    = string<br/>      value  = optional(string, "")<br/>      effect = string<br/>    })), [])<br/>    timeouts = optional(object({<br/>      create = optional(string, null)<br/>      read   = optional(string, null)<br/>      update = optional(string, null)<br/>      delete = optional(string, null)<br/>    }), null)<br/>  })</pre> | `{}` | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | Map of node pool configurations. Each key is the node pool name.<br/><br/>Example:<br/>node\_pools = {<br/>  default = {<br/>    node\_count  = 2<br/>    node\_flavor = "m2a.large"<br/>  }<br/>  gpu = {<br/>    node\_count  = 1<br/>    node\_flavor = "gn1i.xlarge"<br/>    is\_gpu      = true<br/>    labels      = { "nvidia.com/gpu" = "true" }<br/>    taints = [{<br/>      key    = "nvidia.com/gpu"<br/>      value  = "true"<br/>      effect = "NoSchedule"<br/>    }]<br/>  }<br/>} | <pre>map(object({<br/>    # Basic configuration<br/>    node_count  = optional(number, 2)<br/>    node_flavor = optional(string, "m2a.large")<br/>    description = optional(string, "")<br/><br/>    # Image configuration<br/>    kubernetes_version = optional(string, null) # For image selection<br/>    minor_version      = optional(string, null) # Kubernetes version of node pool<br/>    is_gpu             = optional(bool, false)<br/>    image_id           = optional(string, null)<br/><br/>    # Network configuration<br/>    vpc_id             = optional(string, null)<br/>    subnet_ids         = optional(list(string), null)<br/>    security_group_ids = optional(list(string), [])<br/><br/>    # Node configuration<br/>    ssh_key_name       = optional(string, null)<br/>    volume_size        = optional(number, null)<br/>    is_hyper_threading = optional(bool, null)<br/>    user_data          = optional(string, null) # Base64 encoded user script<br/><br/>    # Kubernetes configuration<br/>    labels = optional(map(string), {})<br/>    taints = optional(list(object({<br/>      key    = string<br/>      value  = optional(string, "")<br/>      effect = string # NoExecute, NoSchedule, PreferNoSchedule<br/>    })), [])<br/><br/>    # Auto-scaling configuration<br/>    auto_scaling = optional(object({<br/>      enabled                         = optional(bool, false)<br/>      min_nodes                       = optional(number, 1)<br/>      max_nodes                       = optional(number, 10)<br/>      scale_down_threshold            = optional(number, 50)<br/>      threshold_duration_minutes      = optional(number, 10)<br/>      post_scale_up_exclusion_minutes = optional(number, 10)<br/>    }), null)<br/><br/>    # Scheduled scaling rules<br/>    # schedule_type: "cron" (periodic) or "once" (single execution)<br/>    scheduled_scaling = optional(list(object({<br/>      name          = string<br/>      desired_nodes = number<br/>      schedule_type = string<br/>      start_time    = string<br/>      schedule      = optional(string, null)<br/>    })), [])<br/><br/>    # Timeouts configuration<br/>    timeouts = optional(object({<br/>      create = optional(string, null)<br/>      read   = optional(string, null)<br/>      update = optional(string, null)<br/>      delete = optional(string, null)<br/>    }), null)<br/><br/>    # Lifecycle<br/>    create = optional(bool, true)<br/>  }))</pre> | `{}` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | SSH KeyPair name to inject into nodes. Required by Kakao Cloud. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the cluster (spread across at least 2 AZs). | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the existing VPC for the cluster. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_api_version"></a> [cluster\_api\_version](#output\_cluster\_api\_version) | The API version of the cluster. |
| <a name="output_cluster_created_at"></a> [cluster\_created\_at](#output\_cluster\_created\_at) | The cluster creation timestamp. |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the Kubernetes Engine cluster. |
| <a name="output_cluster_is_upgradable"></a> [cluster\_is\_upgradable](#output\_cluster\_is\_upgradable) | Whether the cluster can be upgraded. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the Kubernetes Engine cluster. |
| <a name="output_cluster_network"></a> [cluster\_network](#output\_cluster\_network) | The cluster network configuration. |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | The status of the cluster. |
| <a name="output_cluster_summary"></a> [cluster\_summary](#output\_cluster\_summary) | Complete cluster summary as a structured object. |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | The Kubernetes version of the cluster. |
| <a name="output_cluster_vpc_info"></a> [cluster\_vpc\_info](#output\_cluster\_vpc\_info) | The cluster VPC information. |
| <a name="output_control_plane_endpoint"></a> [control\_plane\_endpoint](#output\_control\_plane\_endpoint) | The control plane endpoint object (host, port). |
| <a name="output_control_plane_host"></a> [control\_plane\_host](#output\_control\_plane\_host) | The control plane host address. |
| <a name="output_control_plane_port"></a> [control\_plane\_port](#output\_control\_plane\_port) | The control plane port. |
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | The full kubeconfig data source object. |
| <a name="output_kubeconfig_api_server"></a> [kubeconfig\_api\_server](#output\_kubeconfig\_api\_server) | The Kubernetes API server URL. |
| <a name="output_kubeconfig_ca_data"></a> [kubeconfig\_ca\_data](#output\_kubeconfig\_ca\_data) | The base64-encoded CA certificate. |
| <a name="output_kubeconfig_current_context"></a> [kubeconfig\_current\_context](#output\_kubeconfig\_current\_context) | The current context name from kubeconfig. |
| <a name="output_kubeconfig_yaml"></a> [kubeconfig\_yaml](#output\_kubeconfig\_yaml) | The kubeconfig in YAML format (ready to use with kubectl). |
| <a name="output_node_pool_ids"></a> [node\_pool\_ids](#output\_node\_pool\_ids) | Map of node pool names to their IDs. |
| <a name="output_node_pool_names"></a> [node\_pool\_names](#output\_node\_pool\_names) | List of all node pool names. |
| <a name="output_node_pools"></a> [node\_pools](#output\_node\_pools) | Map of node pool configurations and attributes. |
| <a name="output_scheduled_scaling_rules"></a> [scheduled\_scaling\_rules](#output\_scheduled\_scaling\_rules) | Map of scheduled scaling rule configurations. |
<!-- END_TF_DOCS -->