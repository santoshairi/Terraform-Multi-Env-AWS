locals {
  project = "myapp"

  common_tags = {
    Project     = local.project
    Environment = terraform.workspace
    ManagedBy   = "Terraform"
    Owner       = "DevOps"
  }

  env_config = {
    dev = {
      instance_count = 2
      bucket_count   = 1
      table_count    = 1
      volume_size    = 10
      instance_type  = "t2.medium"
    }
    stg = {
      instance_count = 3
      bucket_count   = 1
      table_count    = 1
      volume_size    = 50
      instance_type  = "t2.small"
    }
    prod = {
      instance_count = 4
      bucket_count   = 2
      table_count    = 2
      volume_size    = 80
      instance_type  = "t2.medium"
    }
  }

  env = lookup(local.env_config, terraform.workspace, local.env_config["dev"])
}