// examples/basic-roles/variables.tf

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "example-iam"
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "terraform"
    Project     = "iam-example"
  }
}
