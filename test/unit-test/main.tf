module "ec2_test_autoscaling_group" {
  source = "../../"

  providers = {
    aws.core-vpc = aws.core-vpc # core-vpc-(environment) holds the networking for all accounts
  }

  for_each = try(local.ec2_test.ec2_test_autoscaling_groups, {})

  name = each.key

  ami_name                      = each.value.ami_name
  ami_owner                     = try(each.value.ami_owner, "core-shared-services-production")
  instance                      = merge(local.ec2_test.instance, lookup(each.value, "instance", {}))
  ebs_volumes_copy_all_from_ami = try(each.value.ebs_volumes_copy_all_from_ami, true)
  ebs_volume_config             = lookup(each.value, "ebs_volume_config", {})
  ebs_volumes                   = lookup(each.value, "ebs_volumes", {})
  secretsmanager_secrets_prefix = lookup(each.value, "secretsmanager_secrets_prefix", "test/")
  secretsmanager_secrets        = lookup(each.value, "secretsmanager_secrets", null)
  ssm_parameters_prefix         = lookup(each.value, "ssm_parameters_prefix", "test/")
  ssm_parameters                = lookup(each.value, "ssm_parameters", null)
  autoscaling_group             = merge(local.ec2_test.autoscaling_group, lookup(each.value, "autoscaling_group", {}))
  autoscaling_schedules         = lookup(each.value, "autoscaling_schedules", local.autoscaling_schedules_default)
  iam_resource_names_prefix     = "ec2-test-asg"
  instance_profile_policies     = local.ec2_common_managed_policies
  application_name              = local.application_name
  region                        = local.region
  subnet_ids                    = [data.aws_subnet.private_subnets_a.id]
  tags                          = merge(local.tags, local.ec2_test.tags, try(each.value.tags, {}))
  account_ids_lookup            = local.environment_management.account_ids
  cloudwatch_metric_alarms      = {}
}
