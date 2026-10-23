
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

output "bastion_instance_id" {
  description = "ID of the bastion EC2 instance"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Public IPv4 address of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "app_a_instance_id" {
  description = "ID of the private EC2 instance in VPC A"
  value       = aws_instance.app_a.id
}

output "app_a_private_ip" {
  description = "Private IP address of application instance A"
  value       = aws_instance.app_a.private_ip
}

output "app_b_instance_id" {
  description = "ID of the private EC2 instance in VPC B"
  value       = aws_instance.app_b.id
}

output "app_b_private_ip" {
  description = "Private IP address of application instance B"
  value       = aws_instance.app_b.private_ip
}
