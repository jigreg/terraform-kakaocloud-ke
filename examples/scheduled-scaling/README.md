<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_kakaocloud"></a> [kakaocloud](#requirement\_kakaocloud) | >= 0.2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ke"></a> [ke](#module\_ke) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_credential_id"></a> [application\_credential\_id](#input\_application\_credential\_id) | Kakao Cloud application credential ID. | `string` | n/a | yes |
| <a name="input_application_credential_secret"></a> [application\_credential\_secret](#input\_application\_credential\_secret) | Kakao Cloud application credential secret. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster (4-20 characters). | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes version. | `string` | `"1.29"` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | SSH key name. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs. | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_summary"></a> [cluster\_summary](#output\_cluster\_summary) | Complete cluster summary. |
| <a name="output_node_pools"></a> [node\_pools](#output\_node\_pools) | All node pools information. |
| <a name="output_scheduled_scaling_rules"></a> [scheduled\_scaling\_rules](#output\_scheduled\_scaling\_rules) | Scheduled scaling rules. |
<!-- END_TF_DOCS -->