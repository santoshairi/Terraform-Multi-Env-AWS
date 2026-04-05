terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.38.0"
        
    }
  }


  backend "s3" {
      bucket = "my-terra-bucket09"
      dynamodb_table = "terra-remote-table"
      key = "terraform.tfstate"
      region = "ap-south-1"
  }

}