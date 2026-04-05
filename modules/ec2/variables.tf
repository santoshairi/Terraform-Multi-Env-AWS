variable "instance_type" {}
variable "key_name" {}
variable "instance_name" {}
variable "tags" {
  type = map(string)
  
}

variable "root_volume_size" {
  description = "Root EBS size in GB"
  type = number
  
}

variable "subnet_id" {}
variable "vpc_security_group_ids" {
  type = list(string)
}