# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

# Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name
  }
}

# Create a subnet within the VPC
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = var.subnet_name
  }

}

# Create a route table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.rt_name
  }

}

# Associate the subnet with the route table
resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

# Create a security group for the EC2 instances
resource "aws_security_group" "instance_sg" {
  description = "Security group for the EC2 instances"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name = var.sg_name
  }
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  /*ingress = [
    for port in [22, 8080, 9000, 9090, 80] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      ipv6_cidr_blocks = ["::/0"]
      self             = false
      prefix_list_ids  = []
      security_groups  = []
      cidr_blocks      = ["0.0.0.0/0"]
    }
    ]*/

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Allocate Elastic IPs
resource "aws_eip" "eip" {
  for_each = aws_instance.ec2_instances
  domain   = "vpc" # Allocate the EIPs in a VPC
}

# Launch EC2 instances 
resource "aws_instance" "ec2_instances" {
  for_each                    = var.instance_tags
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet.id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]
  associate_public_ip_address = true
  user_data                   = templatefile("./install.sh", {})

  /*
  # User data to execute shell script
  user_data = <<-EOF
               #!/bin/bash
               sudo apt-get update
               sudo apt-get upgrade -y
               EOF
  */

  # Block to specify parameters for additional EBS volume attached to the EC2 instances
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = var.instance_volume_size # Size in GB
  }

  tags = {
    Name = each.value
  }
}

# Associate each Elastic IP with its corresponding EC2 instance
resource "aws_eip_association" "eip_association" {
  for_each      = aws_instance.ec2_instances
  instance_id   = each.value.id
  allocation_id = aws_eip.eip[each.key].id
}



/*
# Allocate Elastic IPs
resource "aws_eip" "eip" {
  count = var.count
  domain = "vpc"  # Allocate the EIPs in a VPC
}

//Create EC2 intance with count  
#Launch EC2 instances 
resource "aws_instance" "ec2_instances" {
  count         = var.count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet.id
  key_name      = var.key_name
  security_groups = [aws_security_group.instance_sg.name]
  associate_public_ip_address = true

  # User data to execute shell script
   user_data = <<-EOF
               #!/bin/bash
               sudo apt-get update
               sudo apt-get upgrade -y
               EOF
  
  # Block to specify parameters for additional EBS volume attached to the EC2 instances
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = var.instance_volume_size  # Size in GB
  }

  tags = {
    Name = "EC2 Instance ${count.index + 1}"
  }
}

# Associate each Elastic IP with its corresponding EC2 instance
resource "aws_eip_association" "eip_association" {
  count        = var.count
  instance_id  = aws_instance.ec2_instances[count.index].id
  allocation_id = aws_eip.eip[count.index].id
}
*/



/////////////

/*
resource "aws_vpc" "vpc" {


  cidr_block           = "10.0.0.0/16" ##65K range
  enable_dns_hostnames = true
  enable_dns_support   = true


}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_security_group" "allow_all" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  security_groups = [aws_security_group.allow_all.name]
}
*/

/////////

/*
# Attach EBS volume as the root volume
  root_block_device {
    volume_size = 8  # Size in GB
    volume_type = "gp2"  # General Purpose SSD (default)
  }

  # Additional EBS volumes
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 20  # Size in GB
    volume_type = "gp2"  # General Purpose SSD (default)
  }
  ebs_block_device {
    device_name = "/dev/sdc"
    volume_size = 30  # Size in GB
    volume_type = "gp2"  # General Purpose SSD (default)
  }
  */
