
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}


resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_block

  tags = merge(var.tags, {
    Name = "${terraform.workspace}-vpc"
  })
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = var.tags
}


resource "aws_subnet" "public" {
  count = length(local.azs)

  vpc_id     = aws_vpc.myvpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index)

  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${terraform.workspace}-public-${local.azs[count.index]}"
  })
}


resource "aws_subnet" "private" {
  count = length(local.azs)

  vpc_id     = aws_vpc.myvpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index + length(local.azs))

  availability_zone = local.azs[count.index]

  tags = merge(var.tags, {
    Name = "${terraform.workspace}-private-${local.azs[count.index]}"
  })
}