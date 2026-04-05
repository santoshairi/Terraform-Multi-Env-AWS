#  Terraform AWS Multi-Environment Setup (Workspace-Based)

This project provisions AWS infrastructure using **Terraform modules** and **workspace-based environments** (`dev`, `stg`, `prod`).

It follows **production-grade DevOps practices**:
- Modular architecture
- Remote backend (S3 + DynamoDB)
- Workspace-based environment isolation
- Dynamic scaling per environment
- Secure and tagged resources

---

## 📁 Project Structure


## 📁 Project Structure

```
terraform-aws/
│
├── terraform.tf      # backend + required providers
├── provider.tf       # AWS provider configuration
├── variables.tf      # input variables
├── locals.tf         # environment logic & scaling
├── main.tf           # module calls
├── outputs.tf        # outputs
│
└── modules/
    ├── ec2/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── s3/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── dynamodb/
    |   ├── main.tf
    |   ├── variables.tf
    |   └── outputs.tf
    |
    |── VPC
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```


---

## 🧠 Architecture Overview

| Environment | EC2 | S3 | DynamoDB |
|------------|----|----|----------|
| dev        | 2  | 1  | 1        |
| stg        | 3  | 1  | 1        |
| prod       | 4  | 2  | 2        |

---
## 🌐 VPC & Subnet Design (Dynamic CIDR Allocation)

This project uses Terraform’s `cidrsubnet()` function to dynamically generate subnets from a base VPC CIDR block.

### 🔹 VPC CIDR

```hcl
cidr_block = "10.0.0.0/16"


## ⚙️ Terraform Workflow (Commands)

### 1. Initialize Terraform
```bash
terraform init
2. Validate Configuration
terraform validate
3. Create Workspaces (First Time Only)
terraform workspace new dev
terraform workspace new stg
terraform workspace new prod
4. Select Workspace
terraform workspace select dev
5. Plan Infrastructure
terraform plan
6. Apply Infrastructure
terraform apply
7. Destroy Infrastructure (if needed)
terraform destroy
🔄 Switching Environments
terraform workspace select stg
terraform apply
terraform workspace select prod
terraform apply
🔐 Remote Backend
backend "s3" {
  bucket         = "your-terraform-state-bucket"
  key            = "env/<workspace>/terraform.tfstate"
  region         = "ap-south-1"
  dynamodb_table = "terraform-lock"
}
🔑 Prerequisites
Terraform >= 1.5
AWS CLI configured (aws configure)
Existing EC2 Key Pair (e.g. prod-server-key)
S3 bucket for Terraform state
DynamoDB table for state locking
🏷️ Tagging Strategy

All resources include:

Project
Environment
Owner
ManagedBy (Terraform)
💾 EBS Configuration
Root volume explicitly defined
Uses gp3
Encrypted by default
Size varies per environment