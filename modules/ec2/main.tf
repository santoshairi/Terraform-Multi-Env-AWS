data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "my-ec2" {
  ami           = data.aws_ami.latest.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
    encrypted = true
  }

  tags = merge(var.tags, {
    Name = var.instance_name
  })
}