
variable "cidr_block" {
  description = "The IPv4 CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnet" {
  description = "IPv4 CIDR block used as public subnet"
}

variable "private_subnet" {
  description = " IPv4 CIDR block used as private subnet"
}

variable "availability_zone" {
  description = "Availability zone used by the subnets"
}
