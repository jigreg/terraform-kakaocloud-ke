<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kakaocloud"></a> [kakaocloud](#requirement\_kakaocloud) | ~> 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kakaocloud"></a> [kakaocloud](#provider\_kakaocloud) | 0.2.0 |


## Resources

| Name | Type |
|------|------|
| [kakaocloud_kubernetes_engine_node_pool.this](https://registry.terraform.io/providers/kakaoenterprise/kakaocloud/latest/docs/resources/kubernetes_engine_node_pool) | resource |
| [kakaocloud_instance_flavors.node](https://registry.terraform.io/providers/kakaoenterprise/kakaocloud/latest/docs/data-sources/instance_flavors) | data source |
| [kakaocloud_kubernetes_engine_images.node](https://registry.terraform.io/providers/kakaoenterprise/kakaocloud/latest/docs/data-sources/kubernetes_engine_images) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_scaling"></a> [auto\_scaling](#input\_auto\_scaling) | Resource-based auto-scaling configuration. | <pre>object({<br/>    enabled                         = optional(bool, false)<br/>    min_nodes                       = optional(number, 1)<br/>    max_nodes                       = optional(number, 10)<br/>    scale_down_threshold            = optional(number, 50) # Percentage (0-100), converted to ratio<br/>    threshold_duration_minutes      = optional(number, 10) # Converted to seconds<br/>    post_scale_up_exclusion_minutes = optional(number, 10) # Converted to seconds<br/>  })</pre> | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster this node pool belongs to. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the node pool. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the node pool. | `string` | `""` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | Override the auto-detected image ID. | `string` | `null` | no |
| <a name="input_is_gpu"></a> [is\_gpu](#input\_is\_gpu) | Whether this is a GPU node pool (for image selection). | `bool` | `false` | no |
| <a name="input_is_hyper_threading"></a> [is\_hyper\_threading](#input\_is\_hyper\_threading) | Whether hyper-threading is enabled. true: 2 vCPUs per physical core, false: vCPUs equal to physical cores. | `bool` | `true` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes version for node pool image selection. | `string` | `"1.29"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Kubernetes labels to apply to nodes (key/value pairs). | `map(string)` | `{}` | no |
| <a name="input_minor_version"></a> [minor\_version](#input\_minor\_version) | Kubernetes minor version of the node pool. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the node pool. | `string` | n/a | yes |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Desired number of nodes in the pool (request\_node\_count). | `number` | `2` | no |
| <a name="input_node_flavor"></a> [node\_flavor](#input\_node\_flavor) | Instance flavor for worker nodes (e.g., m2a.large). Used to lookup flavor\_id. | `string` | `"m2a.large"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs to attach to nodes. | `list(string)` | `[]` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | SSH key name to inject into nodes. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the node pool. | `list(string)` | n/a | yes |
| <a name="input_taints"></a> [taints](#input\_taints) | Kubernetes taints to apply to nodes. | <pre>list(object({<br/>    key    = string<br/>    value  = optional(string, "")<br/>    effect = string # NoExecute, NoSchedule, PreferNoSchedule<br/>  }))</pre> | `[]` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Custom timeout settings for create, read, update, delete operations. | <pre>object({<br/>    create = optional(string, "30m")<br/>    read   = optional(string, "5m")<br/>    update = optional(string, "10m")<br/>    delete = optional(string, "5m")<br/>  })</pre> | `null` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User script to run when creating nodes (base64 encoded, up to 16KB). | `string` | `null` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Root volume size in GiB. Required for VM or GPU node pools. | `number` | `"50"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for the node pool. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_auto_scaling_enabled"></a> [auto\_scaling\_enabled](#output\_auto\_scaling\_enabled) | Whether auto-scaling is enabled. |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The creation timestamp. |
| <a name="output_flavor_id"></a> [flavor\_id](#output\_flavor\_id) | The flavor ID of the nodes. |
| <a name="output_image_id"></a> [image\_id](#output\_image\_id) | The image ID of the nodes. |
| <a name="output_is_gpu"></a> [is\_gpu](#output\_is\_gpu) | Whether this is a GPU node pool. |
| <a name="output_is_upgradable"></a> [is\_upgradable](#output\_is\_upgradable) | Whether the node pool is upgradable. |
| <a name="output_node_count"></a> [node\_count](#output\_node\_count) | The current node count. |
| <a name="output_node_pool_id"></a> [node\_pool\_id](#output\_node\_pool\_id) | The ID of the node pool. |
| <a name="output_node_pool_name"></a> [node\_pool\_name](#output\_node\_pool\_name) | The name of the node pool. |
| <a name="output_status"></a> [status](#output\_status) | The status of the node pool. |
<!-- END_TF_DOCS -->