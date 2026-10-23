
output "vpc_a_id" {
  description = "ID of VPC A"
  value       = aws_vpc.vpc_a.id
}

output "vpc_b_id" {
  description = "ID of VPC B"
  value       = aws_vpc.vpc_b.id
}

output "vpc_peering_connection_id" {
  description = "ID of the VPC peering connection"
  value       = aws_vpc_peering_connection.a_b.id
}

output "vpc_a_public_subnet_id" {
  description = "ID of the public subnet in VPC A"
  value       = aws_subnet.a_public.id
}

output "vpc_a_private_subnet_id" {
  description = "ID of the private subnet in VPC A"
  value       = aws_subnet.a_private.id
}

output "vpc_b_private_subnet_id" {
  description = "ID of the private subnet in VPC B"
  value       = aws_subnet.b_private.id
}
