//count = 1
instance_tags = {
  jenkins = "jenkins-instance"
}
ami_id               = "ami-0c1c30571d2dae5c9"
key_name             = "si_key"
instance_type        = "t2.large"
instance_volume_size = 30
vpc_cidr_block       = "10.0.0.0/16"
vpc_name             = "SI VPC"
subnet_cidr_block    = "10.0.1.0/24"
availability_zone    = "eu-west-1a"
igw_name             = "SI IGW"
subnet_name          = "SI Subnet"
rt_name              = "SI Route Table"
sg_name              = "EC2 Instance Security Group"

