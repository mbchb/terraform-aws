/*variable "count" {
  description = "Number of Elastic IPs and EC2 instances to create"
  type        = number
}
*/

variable "instance_tags" {
  type = map(string)
  default = {
    "instance1" = "Instance 1"
  }
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
}

variable "instance_volume_size" {
  description = "Size of the EBS volume to attach to the EC2 instances"
  type        = number
  default     = 20
}

variable "vpc_name" {
  description = "The name of the VPC"
}

variable "igw_name" {
  description = "Name for the Internet Gateway"
  type        = string
}

variable "subnet_name" {
  description = "Name for the subnet"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "The preferred availability zone for the subnet"
  type        = string
  default     = "eu-west-1a"
}

variable "rt_name" {
  description = "Name for the route table"
  type        = string
}

variable "sg_name" {
  description = "Name for the security group"
  type        = string
}
