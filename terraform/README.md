
# Terraform Infrastructure

## Overview

This directory contains Terraform configuration for the AWS VPC Peering project.

The configuration defines:

- Two VPCs with non-overlapping CIDR ranges
- Public and private subnets
- An internet gateway for VPC A
- A VPC peering connection
- Route tables and subnet associations
- Security groups with restricted inbound access
- Three EC2 instances: a bastion host and two private application instances
- Input variables and deployment outputs

## Architecture

| Component | Configuration |
|---|---|
| AWS Region | Asia Pacific (Mumbai) |
| VPC A | `10.10.0.0/16` |
| VPC B | `10.20.0.0/16` |
| VPC A public subnet | `10.10.1.0/24` |
| VPC A private subnet | `10.10.2.0/24` |
| VPC B private subnet | `10.20.1.0/24` |
| VPC peering | Private routing between VPC A and VPC B |

## Files

- `main.tf` — VPCs, subnets, gateway, peering, routes and associations
- `security_groups.tf` — Inbound and outbound security rules
- `instances.tf` — EC2 instance definitions
- `variables.tf` — Input variables
- `outputs.tf` — Resource IDs and IP addresses
- `terraform.tfvars.example` — Example input values

## Prerequisites

- Terraform CLI
- An appropriately configured AWS account and credentials
- An SSH public key
- An administrator public IPv4 address in `/32` CIDR notation

## Configuration

Create a local `terraform.tfvars` file based on `terraform.tfvars.example`.

Replace all example placeholders with valid configuration values. Do not commit private keys, credentials, or sensitive information.

## Validation

From this directory, use:

```bash
terraform fmt -check
terraform init -backend=false
terraform validate
```

These commands format-check, initialize provider dependencies, and validate the configuration syntax and structure. They do not establish that the infrastructure has been deployed or that connectivity tests have passed.

## Security Considerations

- Restrict SSH access to an approved administrator IP.
- Keep application instances in private subnets without public IPv4 addresses.
- Use narrowly scoped security group rules.
- Protect SSH private keys and AWS credentials.
- Review planned changes before any deployment.

## Current Status

Infrastructure configuration has been prepared for review. Deployment and connectivity validation remain pending.
