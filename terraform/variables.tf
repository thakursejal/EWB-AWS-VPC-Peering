
variable "aws_region" {
  description = "AWS region for the VPC peering project"
  type        = string
  default     = "ap-south-1"
}

variable "admin_ip_cidr" {
  description = "Administrator public IPv4 address allowed to SSH into the bastion"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.admin_ip_cidr)) && can(regex("/32$", var.admin_ip_cidr))
    error_message = "Enter one valid IPv4 address ending in /32."
  }
}

variable "instance_type" {
  description = "EC2 instance type for the project"
  type        = string
  default     = "t3.micro"
}

variable "ssh_public_key" {
  description = "Public SSH key for the EC2 instances"
  type        = string
  sensitive   = true
}

variable "student_name" {
  description = "Student name used for AWS resource tags"
  type        = string
  default     = "Thakur Sejal"
}
