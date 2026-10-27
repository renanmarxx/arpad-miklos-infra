terraform {
  backend "s3" {
    bucket         = "renan-marx-data-engineering-projects"
    key            = "terraform/state"
    region         = "us-east-2"
    dynamodb_table = "dynamodb-sentinel-01"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.93"
    }
  }
}

provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn = var.assume_role.role_arn
  }

  default_tags {
    tags = var.tags
  }
}
