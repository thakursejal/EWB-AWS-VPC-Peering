
# Amazon Linux 2023 AMI for the selected AWS region
data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# Key pair for SSH access
resource "aws_key_pair" "lab" {
  key_name   = "ewb-lab"
  public_key = var.ssh_public_key

  tags = {
    Name = "ewb-lab"
  }
}

# Bastion host in the public subnet of VPC A
resource "aws_instance" "bastion" {
  ami                         = data.aws_ssm_parameter.al2023_ami.value
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.a_public.id
  private_ip                  = "10.10.1.10"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  key_name                    = aws_key_pair.lab.key_name

  tags = {
    Name = "ewb-bastion"
  }
}

# Private application instance in VPC A
resource "aws_instance" "app_a" {
  ami                         = data.aws_ssm_parameter.al2023_ami.value
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.a_private.id
  private_ip                  = "10.10.2.10"
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.app_a.id]
  key_name                    = aws_key_pair.lab.key_name

  tags = {
    Name = "ewb-app-a"
  }
}

# Private application instance in VPC B
resource "aws_instance" "app_b" {
  ami                         = data.aws_ssm_parameter.al2023_ami.value
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.b_private.id
  private_ip                  = "10.20.1.10"
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.app_b.id]
  key_name                    = aws_key_pair.lab.key_name

  tags = {
    Name = "ewb-app-b"
  }
}
