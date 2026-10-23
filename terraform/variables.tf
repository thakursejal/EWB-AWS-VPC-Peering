
variable "aws_region" {
  description = "AWS region for the VPC peering infrastructure"
  type        = string
  default     = "ap-south-1"
}

variable "admin_ip_cidr" {
  description = "Public IPv4 CIDR allowed to access the bastion host over SSH"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.admin_ip_cidr)) && can(regex("/32$", var.admin_ip_cidr))
    error_message = "Provide a single administrator IPv4 address in CIDR notation, ending in /32."
  }
}
