variable "ec2name" {
  description = "name for the EC2 instance"
  default     = "EC2"
}

variable "amiid" {
  description = "amiid used by the EC2 instance created"
  default     = "ami-1e749f67"
}

variable "size" {
  description = "instance type for the EC2"
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "Id of the VPC used by the EC2 instance"
}

variable "subnet_id" {
  description = "Id of the network (public or private) used by the EC2 instance"
}
