# AWS Web Server: Infrastructure as Code with Terraform

![Terraform Check](https://github.com/arsenbazylov/aws-terraform-webserver/actions/workflows/terraform-check.yml/badge.svg)

Terraform configuration that describes a small web server on AWS.
Part of my hands-on path into Cloud Engineering.

## What it manages

- **EC2 instance** (`t3.micro`, Ubuntu) in `eu-north-1` (Stockholm)
- **Security group** allowing SSH (22), HTTP (80) and an app port (8080)
- **Elastic IP** attached to the instance
- **Test server** (`examples/docker-test/`) that installs Docker and starts nginx via
  Docker Compose on first boot, using `user_data` and `examples/docker-test/docker/docker-compose.yml`

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
Copy terraform.tfvars.example to terraform.tfvars and set ypur own IP
```

Note: the AMI ID and key pair name are currently hardcoded for my account
and region. To use this elsewhere, change them in `ec2.tf`.

## Known limitations and next steps

- State is stored in S3 (versioned, encrypted, public access blocked). The bucket was created manually with AWS CLI. Terraform 1.9 has no native S3 locking, so this setup is for a single user
- GitHub Actions runs terraform fmt -check and terraform validate on every push

## Examples

`examples/docker-test/` is a separate Terraform project with its own state.
It starts a temporary EC2 instance that installs Docker and runs nginx with
Docker Compose on first boot. It reuses the security group from the main
project, so apply the main project first. Destroy the example when done.
