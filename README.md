# Modernisation Platform Terraform Module Template 

[![repo standards badge](https://img.shields.io/badge/dynamic/json?color=blue&style=for-the-badge&logo=github&label=MoJ%20Compliant&query=%24.result&url=https%3A%2F%2Foperations-engineering-reports.cloud-platform.service.justice.gov.uk%2Fapi%2Fv1%2Fcompliant_public_repositories%2Fmodernisation-platform-terraform-module-template)](https://operations-engineering-reports.cloud-platform.service.justice.gov.uk/public-github-repositories.html#modernisation-platform-terraform-module-template "Link to report")

## Usage

```hcl

module "template" {

  source = "github.com/ministryofjustice/modernisation-platform-terraform-module-template"

  tags             = local.tags
  application_name = local.application_name

}

```
<!--- BEGIN_TF_DOCS --->


<!--- END_TF_DOCS --->

## Looking for issues?
If you're looking to raise an issue with this module, please create a new issue in the [Modernisation Platform repository](https://github.com/ministryofjustice/modernisation-platform/issues).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.9 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | ~> 2.2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | > 0.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.9 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | ~> 2.2.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.4.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_schedule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_cloudwatch_metric_alarm.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.asm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.lifecycle_hooks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_ami.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ec2_instance_type.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_instance_type) | data source |
| [aws_iam_policy_document.asm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lifecycle_hooks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [cloudinit_config.this](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_ids_lookup"></a> [account\_ids\_lookup](#input\_account\_ids\_lookup) | A map of account names to account ids that can be used for AMI owner | `map(any)` | `{}` | no |
| <a name="input_ami_name"></a> [ami\_name](#input\_ami\_name) | Name of AMI to be used to launch the ec2 instance | `string` | n/a | yes |
| <a name="input_ami_owner"></a> [ami\_owner](#input\_ami\_owner) | Owner of AMI to be used to launch the ec2 instance | `string` | `"core-shared-services-production"` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The name of the application.  This will be name of the environment in Modernisation Platform | `string` | n/a | yes |
| <a name="input_autoscaling_group"></a> [autoscaling\_group](#input\_autoscaling\_group) | See aws\_autoscaling\_group documentation | <pre>object({<br>    desired_capacity          = number<br>    max_size                  = number<br>    min_size                  = number<br>    health_check_grace_period = optional(number)<br>    health_check_type         = optional(string)<br>    force_delete              = optional(bool)<br>    termination_policies      = optional(list(string))<br>    target_group_arns         = optional(list(string))<br>    wait_for_capacity_timeout = optional(number)<br>    initial_lifecycle_hooks = optional(map(object({<br>      default_result       = string<br>      heartbeat_timeout    = number<br>      lifecycle_transition = string<br>    })))<br>    instance_refresh = optional(object({<br>      strategy               = string<br>      min_healthy_percentage = number<br>      instance_warmup        = number<br>    }))<br>    warm_pool = optional(object({<br>      pool_state                  = optional(string)<br>      min_size                    = optional(number)<br>      max_group_prepared_capacity = optional(number)<br>      reuse_on_scale_in           = bool<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_autoscaling_schedules"></a> [autoscaling\_schedules](#input\_autoscaling\_schedules) | See aws\_autoscaling\_schedule documentation.  Key=name.  Values are taken from equivalent autoscaling\_group value if null | <pre>map(object({<br>    min_size         = optional(number)<br>    max_size         = optional(number)<br>    desired_capacity = optional(number)<br>    recurrence       = string<br>  }))</pre> | n/a | yes |
| <a name="input_cloudwatch_metric_alarms"></a> [cloudwatch\_metric\_alarms](#input\_cloudwatch\_metric\_alarms) | Map of cloudwatch metric alarms. | <pre>map(object({<br>    comparison_operator = string<br>    evaluation_periods  = number<br>    metric_name         = string<br>    namespace           = string<br>    period              = number<br>    statistic           = string<br>    threshold           = number<br>    alarm_actions       = list(string)<br>    actions_enabled     = optional(bool, false)<br>    alarm_description   = optional(string)<br>    datapoints_to_alarm = optional(number)<br>    treat_missing_data  = optional(string, "missing")<br>    dimensions          = optional(map(string), {})<br>    tags                = optional(map(string))<br>  }))</pre> | `{}` | no |
| <a name="input_ebs_kms_key_id"></a> [ebs\_kms\_key\_id](#input\_ebs\_kms\_key\_id) | KMS Key to use for EBS volumes if not explicitly set in ebs\_volumes variable.  If null, uses the local account key or the corresponding AMI volume ebs key | `string` | `null` | no |
| <a name="input_ebs_volume_config"></a> [ebs\_volume\_config](#input\_ebs\_volume\_config) | EC2 volume configurations, where key is a label, e.g. flash, which is assigned to the disk in ebs\_volumes.  All disks with same label have the same configuration.  If not specified, use values from the AMI.  If total\_size specified, the volume size is this divided by the number of drives with the given label | <pre>map(object({<br>    iops       = optional(number)<br>    throughput = optional(number)<br>    total_size = optional(number)<br>    type       = optional(string)<br>    kms_key_id = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_ebs_volumes"></a> [ebs\_volumes](#input\_ebs\_volumes) | EC2 volumes, see aws\_ebs\_volume for documentation.  key=volume name, value=ebs\_volume\_config key.  label is used as part of the Name tag | <pre>map(object({<br>    label       = optional(string)<br>    snapshot_id = optional(string)<br>    iops        = optional(number)<br>    throughput  = optional(number)<br>    size        = optional(number)<br>    type        = optional(string)<br>    kms_key_id  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_ebs_volumes_copy_all_from_ami"></a> [ebs\_volumes\_copy\_all\_from\_ami](#input\_ebs\_volumes\_copy\_all\_from\_ami) | If true, ensure all volumes in AMI are also present in EC2.  If false, only create volumes specified in ebs\_volumes var | `bool` | `true` | no |
| <a name="input_iam_resource_names_prefix"></a> [iam\_resource\_names\_prefix](#input\_iam\_resource\_names\_prefix) | Prefix IAM resources with this prefix, e.g. ec2-database | `string` | `"ec2"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | EC2 launch template / instance settings, see aws\_instance documentation | <pre>object({<br>    disable_api_termination      = bool<br>    instance_type                = string<br>    key_name                     = string<br>    monitoring                   = optional(bool, true)<br>    metadata_options_http_tokens = optional(string, "required")<br>    metadata_endpoint_enabled    = optional(string, "enabled")<br>    vpc_security_group_ids       = list(string)<br>    private_dns_name_options = optional(object({<br>      enable_resource_name_dns_aaaa_record = optional(bool)<br>      enable_resource_name_dns_a_record    = optional(bool)<br>      hostname_type                        = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_instance_profile_policies"></a> [instance\_profile\_policies](#input\_instance\_profile\_policies) | A list of managed IAM policy document ARNs to be attached to the instance profile | `list(string)` | n/a | yes |
| <a name="input_lb_target_groups"></a> [lb\_target\_groups](#input\_lb\_target\_groups) | Map of load balancer target groups, where key is the name.  vpc\_id needs setting if this is used | <pre>map(object({<br>    port                 = optional(number)<br>    protocol             = optional(string)<br>    target_type          = string<br>    deregistration_delay = optional(number)<br>    health_check = optional(object({<br>      enabled             = optional(bool)<br>      interval            = optional(number)<br>      healthy_threshold   = optional(number)<br>      matcher             = optional(string)<br>      path                = optional(string)<br>      port                = optional(number)<br>      timeout             = optional(number)<br>      unhealthy_threshold = optional(number)<br>    }))<br>    stickiness = optional(object({<br>      enabled         = optional(bool)<br>      type            = string<br>      cookie_duration = optional(number)<br>      cookie_name     = optional(string)<br>    }))<br>    attachments = optional(list(object({<br>      target_id         = string<br>      port              = optional(number)<br>      availability_zone = optional(string)<br>    })), [])<br>  }))</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Provide a unique name for the auto scale group | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Destination AWS Region for the infrastructure | `string` | `"eu-west-2"` | no |
| <a name="input_ssm_parameters"></a> [ssm\_parameters](#input\_ssm\_parameters) | A map of SSM parameters to create.  If parameters are manually created, set to {} so IAM role still created | <pre>map(object({<br>    random = object({<br>      length  = number<br>      special = bool<br>    })<br>    description = string<br>  }))</pre> | `null` | no |
| <a name="input_ssm_parameters_prefix"></a> [ssm\_parameters\_prefix](#input\_ssm\_parameters\_prefix) | Optionally prefix ssm parameters with this prefix.  Add a trailing / | `string` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet ids given to the ASG to set the associated AZs (and therefore redundancy of the ASG instances) | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags to be applied to resources | `map(any)` | n/a | yes |
| <a name="input_user_data_cloud_init"></a> [user\_data\_cloud\_init](#input\_user\_data\_cloud\_init) | Use this instead of user\_data\_raw to run multiple scripts using cloud\_init | <pre>object({<br>    args    = optional(map(string))<br>    scripts = optional(list(string))<br>    write_files = optional(map(object({<br>      path        = string<br>      owner       = string<br>      permissions = string<br>    })), {})<br>  })</pre> | `null` | no |
| <a name="input_user_data_raw"></a> [user\_data\_raw](#input\_user\_data\_raw) | Base64 encoded user data, script or cloud formation template | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc id which only needs populating if lb\_target\_groups is set | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_target_groups"></a> [lb\_target\_groups](#output\_lb\_target\_groups) | map of aws\_lb\_target\_group resources |
<!-- END_TF_DOCS -->