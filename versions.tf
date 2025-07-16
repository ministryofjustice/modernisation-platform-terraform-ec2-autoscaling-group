terraform {
  required_providers {
    aws = {
      version               = "~> 6.0"
      source                = "hashicorp/aws"
      configuration_aliases = [aws.core-vpc]
    }
    cloudinit = {
      version = "~> 2.3"
      source  = "hashicorp/cloudinit"
    }

    random = {
      version = "~> 3.4"
      source  = "hashicorp/random"
    }

    time = {
      version = "~> 0.13"
      source  = "hashicorp/time"
    }
  }
  required_version = "~> 1.0"
}
