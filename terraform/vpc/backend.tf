terraform {
  backend "s3" {
    bucket = "terrafrom-tf-state-three"
    key    = "us-west-2/int/vpc/terraform.tfstate"
    region = "us-west-2"

    encrypt = true
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}