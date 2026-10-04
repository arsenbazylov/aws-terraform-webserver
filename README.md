# AWS Web Server: Infrastructure as Code with Terraform

Terraform configuration that describes a small web server on AWS.
Part of my hands-on path into Cloud Engineering.

## What it manages

- **EC2 instance** (`t3.micro`, Ubuntu) in `eu-north-1` (Stockholm)
- **Security group** allowing SSH (22), HTTP (80) and an app port (8080)
- **Elastic IP** attached to the instance

## How it was built

The server was first created by hand in the AWS Console. I then described it
in Terraform and brought it under management with `terraform import`.
After fixing the differences between the code and the real resources,
`terraform plan` reports no changes.

## Requirements

- Terraform >= 1.5
- AWS CLI configured with an IAM user that can manage EC2
- An existing EC2 key pair (the code uses `my-first-key`)

## Usage

```bash
terraform init
terraform plan
terraform apply
```

Note: the AMI ID and key pair name are currently hardcoded for my account
and region. To use this elsewhere, change them in `ec2.tf`.

## Known limitations and next steps

- SSH is open to `0.0.0.0/0`. It should be restricted to my own IP.
- Terraform state is stored locally. Plan: move it to an S3 backend.
- Add a Docker Compose setup for the nginx container.
- Add a GitHub Actions workflow to run `terraform validate` and `plan`.
