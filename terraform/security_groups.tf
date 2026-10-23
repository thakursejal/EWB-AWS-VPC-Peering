
resource "aws_security_group" "bastion" {
  name        = "ewb-sg-bastion"
  description = "SSH access to the public bastion from the administrator IP"
  vpc_id      = aws_vpc.a.id

  ingress {
    description = "SSH from administrator public IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip_cidr]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ewb-sg-bastion"
  }
}

resource "aws_security_group" "app_a" {
  name        = "ewb-sg-app-a"
  description = "Restricted SSH and ICMP for App-A"
  vpc_id      = aws_vpc.a.id

  ingress {
    description = "SSH from bastion private IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.1.10/32"]
  }

  ingress {
    description = "ICMP echo requests from App-B"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.20.1.10/32"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ewb-sg-app-a"
  }
}

resource "aws_security_group" "app_b" {
  name        = "ewb-sg-app-b"
  description = "Restricted SSH and ICMP for App-B"
  vpc_id      = aws_vpc.b.id

  ingress {
    description = "SSH from bastion private IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.1.10/32"]
  }

  ingress {
    description = "ICMP echo requests from App-A"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.10.2.10/32"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ewb-sg-app-b"
  }
}
