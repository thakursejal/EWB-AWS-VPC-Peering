8
# AWS VPC Peering — Project Report

## 1. Project Information

- **Project:** AWS VPC Peering
- **Organization:** EWB Courses
- **Student Name:** Thakur Sejal
- **Technology:** Amazon Web Services (AWS), Terraform
- **Region:** Asia Pacific (Mumbai), `ap-south-1`

## 2. Objective

To design and document private network connectivity between two Amazon VPCs using VPC Peering, route tables, security groups, and private EC2 instances.

## 3. Architecture

The planned architecture contains:

- VPC A: `10.10.0.0/16`
- VPC B: `10.20.0.0/16`
- One public and one private subnet in VPC A
- One private subnet in VPC B
- An internet gateway attached to VPC A
- A VPC peering connection with routes in both VPCs
- A bastion host and two private application instances

Refer to [Architecture Documentation](architecture.md).

## 4. Resource Inventory

| Resource | Name | Resource ID |
|---|---|---|
| VPC A | `ewb-vpc-a` | Pending |
| VPC B | `ewb-vpc-b` | Pending |
| Internet gateway | `ewb-igw-a` | Pending |
| VPC peering | `ewb-a-b-peer` | Pending |
| Bastion instance | `ewb-bastion` | Pending |
| Application A | `ewb-app-a` | Pending |
| Application B | `ewb-app-b` | Pending |

Replace pending values with actual resource IDs if the infrastructure is deployed.

## 5. Routing and Security

The design uses VPC peering routes to enable private IP communication between the VPCs. Security groups restrict SSH and ICMP traffic to the specified source addresses.

Application instances are intended to remain in private subnets without public IPv4 addresses.

## 6. Testing and Results

Refer to [Validation Checklist](validation-checklist.md).

Record actual test results and attach genuine evidence after executing the tests in AWS.

| Test | Result | Evidence |
|---|---|---|
| Baseline connectivity | Pending | Pending |
| Application A to B connectivity | Pending | Pending |
| Application B to A connectivity | Pending | Pending |
| SSH through bastion | Pending | Pending |
| ICMP rule removal and restoration | Pending | Pending |

## 7. Challenges and Observations

Document implementation challenges, troubleshooting steps, and observations after validation.

## 8. Learning Outcomes

- Understanding VPCs and subnet design
- Configuring VPC peering and route tables
- Applying security group rules
- Understanding bastion-based access to private instances
- Using Terraform to describe cloud infrastructure

## 9. Cleanup

Document the cleanup of all resources created for the lab, including EC2 instances, volumes, VPC peering, routes, security groups, subnets, route tables, the internet gateway, and VPCs.

## 10. Project Status

**Current status:** Infrastructure configuration and documentation prepared. Live deployment, connectivity tests, and cleanup evidence remain pending.

Do not mark deployment or testing as completed until supported by actual results.

## Architecture and Implementation Evidence

### Network Architecture
Refer to [AWS VPC Peering Architecture](architecture.md) for the network diagram and IP address plan.

### Resource Inventory
Record the actual AWS resource IDs after deployment.

| Resource | Name | Resource ID |
|---|---|---|
| VPC A | ewb-vpc-a | |
| VPC B | ewb-vpc-b | |
| VPC Peering | ewb-a-b-peer | |
| Internet Gateway | ewb-igw-a | |
| Bastion EC2 | ewb-bastion | |
| App-A EC2 | ewb-app-a | |
| App-B EC2 | ewb-app-b | |

### Test Evidence
For each test, record the actual result and attach a screenshot.

- VPC peering status: 
- App-A to App-B connectivity:
- App-B to App-A connectivity:
- SSH through bastion:
- Private instances have no public IPv4:
- ICMP rule removal and restoration test:

### Lessons Learned
Document what you learned about VPC CIDR ranges, route tables, VPC peering, security groups, and private connectivity.

### Cleanup Verification
Record the cleanup actions and verify that all project resources have been removed.

