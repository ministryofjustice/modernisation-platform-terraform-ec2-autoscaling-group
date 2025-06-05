terraform {
  required_providers {
    aws = {
      version = "~> 5.0"
      source  = "hashicorp/aws"
    }
    random = {
      source  = "hashicorp/http"
      version = "~> 3.5"
    }
  }
  required_version = ">= 1.0.1"
}
