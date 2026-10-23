
variable "aws_region" {
  description = "AWS region for the VPC peering infrastructure"
  type        = string
  default     = "ap-south-1"
}

variable "admin_ip_cidr" {
  description = "Administrator public IPv4 address permitted to access the bastion"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.admin_ip_cidr)) && can(regex("/32$", var.admin_ip_cidr))
    error_message = "Provide a single administrator IPv4 address in CIDR notation ending in /32."
  }
}

variable "instance_type" {
  description = "EC2 instance type for the lab"
  type        = string
  default     = "t3.micro"
}

variable "ssh_public_key" {
  description = "Public SSH key associated with the EC2 instances"
  type        = string
  sensitive   = true
}
