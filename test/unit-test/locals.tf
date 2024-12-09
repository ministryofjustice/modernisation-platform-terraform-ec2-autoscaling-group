# This data sources allows us to get the Modernisation Platform account information for use elsewhere
# (when we want to assume a role in the MP, for instance)
data "aws_organizations_organization" "root_account" {}

# Get the environments file from the main repository
data "http" "environments_file" {
  url = "https://raw.githubusercontent.com/ministryofjustice/modernisation-platform/main/environments/${local.application_name}.json"
}
locals {

  # create map of common managed policies that can be attached to ec2 instance profiles
  ec2_common_managed_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    ec2-test-common-policy       = aws_iam_policy.ec2_test_common_policy.arn
  }

  tags = {
    component = "test"
  }
  subnet_set             = var.networking[0].set
  vpc_name               = var.networking[0].business-unit
  environment_management = jsondecode(data.aws_secretsmanager_secret_version.environment_management.secret_string)
  provider_name          = "core-vpc-${local.environment}"
  application_name       = "testing-test"
  environment            = "test"
  business_unit          = var.networking[0].business-unit
  region                 = "eu-west-2"
  availability_zone_1    = "eu-west-2a"
  availability_zone_2    = "eu-west-2b"
  autoscaling_schedules_default = {
    "scale_up" = {
      recurrence = "0 7 * * Mon-Fri"
    }
    "scale_down" = {
      desired_capacity = 0
      recurrence       = "0 19 * * Mon-Fri"
    }
  }
  ec2_test = {
    tags = {
      component = "test"
    }

    instance = {
      disable_api_termination      = false
      instance_type                = "t3.micro"
      key_name                     = aws_key_pair.ec2-terratest-user.key_name
      monitoring                   = false
      metadata_options_http_tokens = "required"
      vpc_security_group_ids       = [aws_security_group.test.id]
    }

    user_data_cloud_init = {
      args = {
        lifecycle_hook_name  = "ready-hook"
        branch               = "main"
        ansible_repo         = "modernisation-platform-configuration-management"
        ansible_repo_basedir = "ansible"
        ansible_args         = "--tags ec2provision"
      }
      scripts = [
        "install-ssm-agent.sh.tftpl",
        "ansible-ec2provision.sh.tftpl",
        "post-ec2provision.sh.tftpl"
      ]
    }

    route53_records = {
      create_internal_record = true
      create_external_record = false
    }

    # user can manually increase the desired capacity to 1 via CLI/console
    # to create an instance
    autoscaling_group = {
      desired_capacity = 0
      max_size         = 2
      min_size         = 0
    }

    ec2_test_instances = {
      # Remove data.aws_kms_key from cmk.tf once the NDH servers are removed
      example-test-instance-1 = {
        tags = {
          server-type = "private"
          description = "Standalone EC2 for testing RHEL7.9 NDH App"
          monitored   = false
          os-type     = "Linux"
          component   = "ndh"
          environment = "test"
        }
        ebs_volumes = {
          "/dev/sda1" = { kms_key_id = data.aws_kms_key.default_ebs.arn }
        }
        ami_name  = "RHEL-7.9_HVM-*"
        ami_owner = "309956199498"
      }
      example-test-instance-2 = {
        tags = {
          server-type = "private"
          description = "Standalone EC2 for testing RHEL7.9 NDH EMS"
          monitored   = false
          os-type     = "Linux"
          component   = "ndh"
          environment = "test"
        }
        ebs_volumes = {
          "/dev/sda1" = { kms_key_id = data.aws_kms_key.default_ebs.arn }
        }
        ami_name  = "RHEL-7.9_HVM-*"
        ami_owner = "309956199498"
      }
    }
    ec2_test_autoscaling_groups = {
      dev-redhat-rhel610 = {
        tags = {
          description = "For testing official RedHat RHEL6.10 image"
          monitored   = false
          os-type     = "Linux"
          component   = "test"
        }
        instance = {
          instance_type                = "t2.medium"
          metadata_options_http_tokens = "optional"
        }
        ami_name  = "RHEL-7.9_HVM-*"
        ami_owner = "309956199498"
      }
    }
  }
}

# create single managed policy
resource "aws_iam_policy" "ec2_test_common_policy" {
  name        = "ec2-test-common-policy"
  path        = "/"
  description = "Common policy for all ec2 instances"
  policy      = data.aws_iam_policy_document.ec2_test_common_combined.json
  tags = merge(
    local.tags,
    {
      Name = "ec2-common-policy"
    },
  )
}

# Keypair for ec2-terratest-user
resource "aws_key_pair" "ec2-terratest-user" {
  key_name   = "ec2-terratest-user"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
  tags = merge(
    local.tags,
    {
      Name = "ec2-terratest-user"
    },
  )
}