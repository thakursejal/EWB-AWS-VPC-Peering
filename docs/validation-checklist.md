
# VPC Peering Validation Checklist

## 1. Network Configuration

- [ ] Confirm both VPCs have the intended, non-overlapping CIDR ranges.
- [ ] Confirm all three subnets use the correct CIDR ranges.
- [ ] Confirm each subnet is associated with its intended route table.
- [ ] Confirm the internet gateway is attached to VPC A.
- [ ] Confirm the VPC peering connection is active.

## 2. Route Validation

- [ ] Confirm the VPC A public route table has a default route to the internet gateway.
- [ ] Confirm the VPC A public route table has a route to VPC B through peering.
- [ ] Confirm the VPC A private route table has a route to VPC B through peering.
- [ ] Confirm the VPC B private route table has a route to VPC A through peering.

## 3. Security Validation

- [ ] Confirm bastion SSH access is restricted to the approved administrator IP.
- [ ] Confirm application instances do not have public IPv4 addresses.
- [ ] Confirm SSH access to private instances is restricted to the bastion host.
- [ ] Confirm ICMP rules allow only the intended application-instance traffic.

## 4. Connectivity Tests

- [ ] Record the baseline ping result before the peering routes are enabled.
- [ ] Test ping from Application A to Application B after configuration.
- [ ] Test ping from Application B to Application A after configuration.
- [ ] Test SSH connectivity to Application B through the bastion host.
- [ ] Temporarily remove the intended ICMP rule and record the ping result.
- [ ] Restore the rule and confirm connectivity is restored.

## 5. Evidence and Cleanup

- [ ] Capture genuine AWS console evidence for the configured resources.
- [ ] Record resource IDs and route table associations.
- [ ] Record actual command outputs and test results.
- [ ] Confirm all resources created for the lab have been cleaned up.

## Results Record

| Test | Expected result | Actual result |
|---|---|---|
| Baseline ping | Fails before required peering routes are enabled | Pending |
| Application A to B ping | Succeeds when routes and rules are configured | Pending |
| Application B to A ping | Succeeds when routes and rules are configured | Pending |
| Bastion SSH path | Private instance reachable through authorized bastion access | Pending |
| ICMP rule removed | Ping fails when that rule is required for the path | Pending |
| ICMP rule restored | Ping succeeds when all required paths and rules are correct | Pending |

**Status:** These are planned validation steps. Update the actual-result column only after performing and recording each test in the target AWS environment.
## Required Connectivity Tests

### 1. Private IP Address Verification
- [ ] Confirm the bastion instance has a public IPv4 address.
- [ ] Confirm App-A has no public IPv4 address.
- [ ] Confirm App-B has no public IPv4 address.

### 2. VPC Peering Connectivity
- [ ] Verify the VPC peering connection is active.
- [ ] Verify VPC A has a route to `10.20.0.0/16` through the peering connection.
- [ ] Verify VPC B has a route to `10.10.0.0/16` through the peering connection.
- [ ] Test ping from App-A (`10.10.2.10`) to App-B (`10.20.1.10`).
- [ ] Test ping from App-B (`10.20.1.10`) to App-A (`10.10.2.10`).
- [ ] Verify SSH access to both private instances through the bastion.

### 3. Security Rule Verification
- [ ] Verify SSH access to the bastion is restricted to the administrator's IP.
- [ ] Verify private instances accept SSH only from the bastion.
- [ ] Temporarily remove the required ICMP rule, confirm ping fails, then restore the rule and confirm connectivity.

### 4. Evidence and Cleanup
- [ ] Capture screenshots of route tables and the active peering connection.
- [ ] Record actual connectivity test results.
- [ ] Verify all project resources are deleted after testing.
