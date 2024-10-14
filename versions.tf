terraform {
  required_providers {
    aws = {
      version               = "~> 5.0"
      source                = "hashicorp/aws"
      configuration_aliases = [aws.core-vpc]
    }
    cloudinit = {
      version = "~> 2.3.5"
      source  = "hashicorp/cloudinit"
    }

    random = {
      version = "~> 3.6"
      source  = "hashicorp/random"
    }

    time = {
      version = "> 0.12.1"
      source  = "hashicorp/time"
    }
  }
  required_version = "~> 1.0"
}
