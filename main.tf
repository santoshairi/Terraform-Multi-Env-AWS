module "ec2" {
  source = "./modules/ec2"

  for_each = {
    for i in range(local.env.instance_count) :
    i => "${local.project}-${terraform.workspace}-ec2-${i}"
  }

  instance_type = local.env.instance_type
  key_name      = var.key_name
  instance_name = each.value
  tags          = local.common_tags
  root_volume_size = local.env.volume_size

    subnet_id = element(
    module.vpc.public_subnets,
    each.key % length(module.vpc.public_subnets)
  )
  vpc_security_group_ids = [module.sg.sg_id]
}

module "s3" {
  source = "./modules/s3"

  for_each = {
    for i in range(local.env.bucket_count) :
    i => "${local.project}-${terraform.workspace}-bucket-${i}"
  }

  bucket_name = each.value
  tags        = local.common_tags
}

module "dynamodb" {
  source = "./modules/dynamodb"

  for_each = {
    for i in range(local.env.table_count) :
    i => "${local.project}-${terraform.workspace}-table-${i}"
  }

  table_name = each.value
  tags       = local.common_tags
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block            = "10.0.0.0/16"

  tags = local.common_tags
}

module "sg" {
  source = "./modules/security_group"

  vpc_id = module.vpc.vpc_id   
  tags   = local.common_tags
}