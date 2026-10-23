
# Bastion host security group
resource "aws_security_group" "bastion" {
  name        = "ewb-sg-bastion"
  description = "SSH access to the bastion host"
  vpc_id      = aws_vpc.vpc_a.id

  ingress {
    description = "SSH from approved administrator IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ewb-sg-bastion"
  }
}

# Private application server in VPC A
resource "aws_security_group" "app_a" {
  name        = "ewb-sg-app-a"
  description = "Restricted access to application server A"
  vpc_id      = aws_vpc.vpc_a.id

  ingress {
    description = "SSH from bastion security group"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [
      aws_security_group.bastion.id
    ]
  }

  ingress {
    description = "ICMP from application server B"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.20.1.10/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ewb-sg-app-a"
  }
}

# Private application server in VPC B
resource "aws_security_group" "app_b" {
  name        = "ewb-sg-app-b"
  description = "Restricted access to application server B"
  vpc_id      = aws_vpc.vpc_b.id

  ingress {
    description = "SSH from bastion security group"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [
      aws_security_group.bastion.id
    ]
  }

  ingress {
    description = "ICMP from application server A"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.10.2.10/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ewb-sg-app-b"
  }
}
