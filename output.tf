output "ec2_instance_ids" {
  value = [for i in module.ec2 : i.instance_id]
}

output "ec2_public_ips" {
  value = [for i in module.ec2 : i.public_ip]
}

output "s3_bucket_names" {
  value = [for b in module.s3 : b.bucket_id]
}

output "dynamodb_table_names" {
  value = [for d in module.dynamodb : d.table_id]
}