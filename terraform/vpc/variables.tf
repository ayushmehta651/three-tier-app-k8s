variable "availability_zone" {
  description = "AZS in a region"
  type        = list(string)
  default 	  = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "region" {
  description = "AWS Region in which to deploy resources (e.g. eu-central-1)."
  type        = string
  default 	  = "us-west-2"
}

