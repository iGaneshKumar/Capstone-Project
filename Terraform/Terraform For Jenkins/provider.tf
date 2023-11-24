terraform {
  required_version = "~> 1.6.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
    time = {
      source = "hashicorp/time"
    }
  }
}

# Provider 1: Default (ap-south-1)
provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}