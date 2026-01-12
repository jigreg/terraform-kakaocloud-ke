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
| [kakaocloud_kubernetes_engine_cluster.this](https://registry.terraform.io/providers/kakaoenterprise/kakaocloud/latest/docs/resources/kubernetes_engine_cluster) | resource |
| [kakaocloud_kubernetes_engine_kubeconfig.this](https://registry.terraform.io/providers/kakaoenterprise/kakaocloud/latest/docs/data-sources/kubernetes_engine_kubeconfig) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cni"></a> [cni](#input\_cni) | CNI plugin selection. Supported: cilium, calico. | `string` | `"calico"` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the cluster. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the cluster. | `string` | `""` | no |
| <a name="input_is_allocate_fip"></a> [is\_allocate\_fip](#input\_is\_allocate\_fip) | Whether to allocate a floating IP to the control plane. | `bool` | `true` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes minor version for the control plane (e.g., '1.29', '1.30'). | `string` | `"1.29"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Kubernetes Engine cluster (4-20 characters). | `string` | n/a | yes |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | CIDR block for Pod networks. | `string` | `"192.168.0.0/16"` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | CIDR block for Service networks. | `string` | `"172.16.0.0/12"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the cluster. | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the existing VPC for the cluster. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_version"></a> [api\_version](#output\_api\_version) | The API version of the cluster. |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the Kubernetes Engine cluster. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the Kubernetes Engine cluster. |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | The status of the cluster (Pending, Provisioning, Provisioned, Updating, Deleting, Failed). |
| <a name="output_control_plane_endpoint"></a> [control\_plane\_endpoint](#output\_control\_plane\_endpoint) | The control plane endpoint object (host, port). |
| <a name="output_control_plane_host"></a> [control\_plane\_host](#output\_control\_plane\_host) | The control plane host address. |
| <a name="output_control_plane_port"></a> [control\_plane\_port](#output\_control\_plane\_port) | The control plane port. |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The creation timestamp (ISO 8601, UTC). |
| <a name="output_creator_info"></a> [creator\_info](#output\_creator\_info) | Creator information (id, name). |
| <a name="output_failure_message"></a> [failure\_message](#output\_failure\_message) | Error details if the cluster is in Failed status. |
| <a name="output_is_upgradable"></a> [is\_upgradable](#output\_is\_upgradable) | Whether the cluster can be upgraded. |
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | The full kubeconfig data source object. |
| <a name="output_kubeconfig_api_server"></a> [kubeconfig\_api\_server](#output\_kubeconfig\_api\_server) | The Kubernetes API server URL from kubeconfig. |
| <a name="output_kubeconfig_ca_data"></a> [kubeconfig\_ca\_data](#output\_kubeconfig\_ca\_data) | The base64-encoded CA certificate from kubeconfig. |
| <a name="output_kubeconfig_current_context"></a> [kubeconfig\_current\_context](#output\_kubeconfig\_current\_context) | The current context name from kubeconfig. |
| <a name="output_kubeconfig_yaml"></a> [kubeconfig\_yaml](#output\_kubeconfig\_yaml) | The kubeconfig in YAML format. |
| <a name="output_kubernetes_version"></a> [kubernetes\_version](#output\_kubernetes\_version) | The Kubernetes version of the cluster. |
| <a name="output_network"></a> [network](#output\_network) | Network configuration (cni, pod\_cidr, service\_cidr). |
| <a name="output_vpc_info"></a> [vpc\_info](#output\_vpc\_info) | VPC information. |
<!-- END_TF_DOCS -->