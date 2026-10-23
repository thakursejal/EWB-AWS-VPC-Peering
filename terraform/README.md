
# Terraform Infrastructure

## Overview

This directory contains the Terraform configuration for the EWB AWS VPC Peering Student Project.

The infrastructure is designed to demonstrate private IPv4 communication between two AWS VPCs using VPC peering, with a bastion host providing SSH access to private EC2 instances.

## Architecture and Address Plan

| Component | Name | CIDR / Address |
|---|---|---|
| AWS Region | Mumbai | `ap-south-1` |
| VPC A | `ewb-vpc-a` | `10.10.0.0/16` |
| VPC B | `ewb-vpc-b` | `10.20.0.0/16` |
| VPC A public subnet | `ewb-a-public` | `10.10.1.0/24` |
| VPC A private subnet | `ewb-a-private` | `10.10.2.0/24` |
| VPC B private subnet | `ewb-b-private` | `10.20.1.0/24` |
| Bastion | `ewb-bastion` | `10.10.1.10` |
| App-A | `ewb-app-a` | `10.10.2.10` |
| App-B | `ewb-app-b` | `10.20.1.10` |
| Peering connection | `ewb-a-b-peer` | Private routing between VPCs |

## Terraform Files

- `main.tf` — VPCs, subnets, internet gateway, peering, route tables and associations
- `security_groups.tf` — Restricted SSH and ICMP rules
- `instances.tf` — EC2 instances, Amazon Linux 2023 AMI lookup and SSH key pair
- `variables.tf` — Configurable AWS region, administrator IP, instance type, SSH public key and student name
- `outputs.tf` — Resource IDs and instance IP addresses
- `terraform.tfvars.example` — Example input configuration

## Prerequisites

- Terraform CLI 1.5 or later
- AWS credentials configured for the intended account
- Permissions to manage the required VPC, EC2, security group, key pair and routing resources
- An SSH key pair
- Your current public IPv4 address in `/32` CIDR notation

## Configure the Project

1. Open `terraform.tfvars.example`.
2. Create a local file named `terraform.tfvars` in this directory using the example as a template.
3. Replace the placeholders with your actual administrator IP and SSH public key.
4. Keep your SSH private key and AWS credentials outside the repository.

Do not commit `terraform.tfvars`, private keys or AWS credentials.

## Validate the Configuration

Run these commands from the `terraform` directory:

```bash
terraform fmt -recursive
terraform init -backend=false
terraform validate
terraform plan
```

Review the plan before applying any changes.

## Deploy the Infrastructure

After validating the configuration and reviewing the plan, run:

```bash
terraform apply
```

Review the proposed actions and confirm only when you are ready to create the resources.

Display the resource outputs with:

```bash
terraform output
```

Record the resource IDs and IP addresses for the project inventory and final report.

## Connectivity Validation

After deployment, verify the following requirements:

1. Confirm the VPC peering connection is active.
2. Confirm each route table has the required peering route and is associated with the correct subnet.
3. Confirm App-A and App-B do not have public IPv4 addresses.
4. Connect to each private instance through the bastion using SSH ProxyJump.
5. From App-A, test connectivity to App-B:

   ```bash
   ping -c 4 10.20.1.10
   ```

6. From App-B, test connectivity to App-A:

   ```bash
   ping -c 4 10.10.2.10
   ```

7. Temporarily remove the relevant ICMP inbound rule to verify that ping fails, then restore the rule and confirm connectivity again.

Record actual results and capture screenshots for the final report.

## Security Considerations

- Allow bastion SSH only from the administrator's public IP `/32`.
- Allow private-instance SSH only from the bastion private IP.
- Restrict ICMP to the specified peer instance IPs.
- Do not expose SSH or ICMP to `0.0.0.0/0`.
- Keep App-A and App-B in private subnets without public IPv4 addresses.
- Protect AWS credentials and SSH private keys.

## Cleanup

After collecting the required evidence and completing the project, remove the resources managed by this Terraform configuration when they are no longer needed.

From the `terraform` directory, review the resources Terraform plans to destroy:

```bash
terraform plan -destroy
```

When you are ready to remove the resources, run:

```bash
terraform destroy
```

Review the proposed actions before confirming. Verify in the AWS console that the project resources have been removed.

## References

- AWS VPC Peering: https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html
- AWS VPC route tables: https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html
- AWS security groups: https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html
- Terraform AWS provider: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
