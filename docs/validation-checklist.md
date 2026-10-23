
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
