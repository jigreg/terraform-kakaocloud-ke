<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_kakaocloud"></a> [kakaocloud](#requirement\_kakaocloud) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kakaocloud"></a> [kakaocloud](#provider\_kakaocloud) | 0.2.0 |


## Resources

| Name | Type |
|------|------|
| [kakaocloud_kubernetes_engine_scheduled_scaling.this](https://registry.terraform.io/providers/kakaoenterprise/kakaocloud/latest/docs/resources/kubernetes_engine_scheduled_scaling) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Target cluster name. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the scheduled scaling rule. | `bool` | `true` | no |
| <a name="input_desired_nodes"></a> [desired\_nodes](#input\_desired\_nodes) | Target number of nodes to maintain in the node pool. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Scheduled autoscaling rule name. | `string` | n/a | yes |
| <a name="input_node_pool_name"></a> [node\_pool\_name](#input\_node\_pool\_name) | Target node pool name. | `string` | n/a | yes |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | CRON expression for periodic execution (required when schedule\_type is 'cron'). Example: '0 9 * * 1-5' for weekdays at 9am. | `string` | `null` | no |
| <a name="input_schedule_type"></a> [schedule\_type](#input\_schedule\_type) | Schedule type: 'cron' (periodic via CRON) or 'once' (single execution). | `string` | n/a | yes |
| <a name="input_start_time"></a> [start\_time](#input\_start\_time) | Reference time when scheduled autoscaling can run (ISO 8601, UTC). Example: '2025-01-15T09:00:00Z' | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The creation timestamp. |
| <a name="output_desired_nodes"></a> [desired\_nodes](#output\_desired\_nodes) | The target number of nodes. |
| <a name="output_node_pool_name"></a> [node\_pool\_name](#output\_node\_pool\_name) | The name of the node pool this rule applies to. |
| <a name="output_rule_id"></a> [rule\_id](#output\_rule\_id) | The name of the scheduled scaling rule (used as identifier). |
| <a name="output_rule_name"></a> [rule\_name](#output\_rule\_name) | The name of the scheduled scaling rule. |
| <a name="output_schedule_type"></a> [schedule\_type](#output\_schedule\_type) | The schedule type (cron or once). |
<!-- END_TF_DOCS -->