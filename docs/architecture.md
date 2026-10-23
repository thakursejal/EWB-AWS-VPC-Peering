
# AWS VPC Peering Architecture

## Overview

The architecture demonstrates private network connectivity between two Amazon Virtual Private Clouds (VPCs) using VPC Peering.

## Network Diagram

```text
                     AWS Region: ap-south-1
              +----------------------------------+
              |                                  |
              |  VPC A: 10.10.0.0/16             |
              |                                  |
Internet ---->| Internet Gateway                 |
              |        |                         |
              |  Public Subnet                   |
              |  10.10.1.0/24                    |
              |        |                         |
              |  Bastion Host                     |
              |  10.10.1.10                      |
              |        |                         |
              |  Private Subnet                   |
              |  10.10.2.0/24                    |
              |        |                         |
              +--------+-------------------------+
                       |
                       | VPC Peering Connection
                       | Private routing
                       |
              +--------+-------------------------+
              |                                  |
              |  VPC B: 10.20.0.0/16             |
              |                                  |
              |  Private Subnet                   |
              |  10.20.1.0/24                    |
              |        |                         |
              |  Application Instance B          |
              |  10.20.1.10                      |
              |                                  |
              +----------------------------------+

VPC A private application instance:
10.10.2.10
```

## Network Address Plan

| Resource | CIDR / Private IP |
|---|---|
| VPC A | `10.10.0.0/16` |
| VPC B | `10.20.0.0/16` |
| Public subnet A | `10.10.1.0/24` |
| Private subnet A | `10.10.2.0/24` |
| Private subnet B | `10.20.1.0/24` |
| Bastion host | `10.10.1.10` |
| Application A | `10.10.2.10` |
| Application B | `10.20.1.10` |

## Traffic Flow

1. An administrator connects to the bastion host through restricted SSH access.
2. The bastion host provides a controlled administrative path to the private instances.
3. VPC peering routes enable private IP communication between the two VPCs.
4. Security groups restrict SSH and ICMP traffic to the specified source addresses.

## Routing Requirements

- VPC A public route table: internet gateway default route and VPC B peering route.
- VPC A private route table: route to `10.20.0.0/16` through the peering connection.
- VPC B private route table: route to `10.10.0.0/16` through the peering connection.

## Status

This diagram represents the planned architecture. Actual deployment and connectivity must be verified in the AWS environment.
```
