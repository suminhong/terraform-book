<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_merge_ec2_volume_set"></a> [merge\_ec2\_volume\_set](#module\_merge\_ec2\_volume\_set) | ../chapter9_utility/3_merge_map_in_list | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ebs_volume.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_volume_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ec2_set"></a> [ec2\_set](#input\_ec2\_set) | EC2별 명세 Set | <pre>map(object({<br/>    # required<br/>    env             = string<br/>    team            = string<br/>    service         = string<br/>    ami_id          = string<br/>    instance_type   = string<br/>    subnet          = string<br/>    az              = string<br/>    security_groups = list(string)<br/>    # optional<br/>    os_type    = optional(string, "linux")<br/>    ec2_key    = optional(string)<br/>    ec2_role   = optional(string)<br/>    private_ip = optional(string)<br/>    # volumes<br/>    root_volume = object({<br/>      size = number<br/>      type = optional(string, "gp3")<br/>    })<br/>    additional_volumes = optional(list(object({<br/>      device = string<br/>      size   = number<br/>      type   = optional(string, "gp3")<br/>      iops   = optional(number)<br/>    })), [])<br/>  }))</pre> | n/a | yes |
| <a name="input_sg_id_map"></a> [sg\_id\_map](#input\_sg\_id\_map) | 보안 그룹 ID 맵 데이터 | `map(string)` | n/a | yes |
| <a name="input_subnet_id_map"></a> [subnet\_id\_map](#input\_subnet\_id\_map) | 서브넷 ID 맵 데이터 | `map(map(string))` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | 모든 리소스에 적용될 태그 (map) | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | EC2가 존재할 VPC의 ID | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | EC2가 존재할 VPC의 이름 | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_id"></a> [ec2\_id](#output\_ec2\_id) | EC2 ID 맵 |
| <a name="output_ec2_info"></a> [ec2\_info](#output\_ec2\_info) | EC2 정보 맵 |
<!-- END_TF_DOCS -->
