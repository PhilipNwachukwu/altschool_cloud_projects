##################################################################################
# DATA
##################################################################################

# data "aws_ssm_parameter" "ami" {
#   name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
# }

# Debian 11 Bullseye
data "aws_ami" "debian-11" {
  most_recent = true

  owners = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-11-amd64-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = local.common_tags

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = local.common_tags

}

resource "aws_subnet" "subnet" {

  count  = length(var.subnets_cidr) #number of times the block will run is equal                                       to length of subnet's_cidr list
  vpc_id = aws_vpc.vpc.id

  /*when block runs for first time, first value form list subnet's_cidr will be                                  
     passed and when block runs for second time   
     second value form list subnet's_cidr will be passed*/

  cidr_block              = element(var.subnets_cidr, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = local.common_tags

  # tags = {

  #   Name = "My-Subnet-${count.index + 1}"
  # }

}

# resource "aws_subnet" "subnet1" {
#   cidr_block              = var.vpc_subnets_cidr_block[0]
#   vpc_id                  = aws_vpc.vpc.id
#   map_public_ip_on_launch = var.map_public_ip_on_launch
#   availability_zone       = data.aws_availability_zones.available.names[0]

#   tags = local.common_tags
# }

# resource "aws_subnet" "subnet2" {
#   cidr_block              = var.vpc_subnets_cidr_block[1]
#   vpc_id                  = aws_vpc.vpc.id
#   map_public_ip_on_launch = var.map_public_ip_on_launch
#   availability_zone       = data.aws_availability_zones.available.names[1]

#   tags = local.common_tags
# }

# resource "aws_subnet" "subnet3" {
#   cidr_block              = var.vpc_subnets_cidr_block[2]
#   vpc_id                  = aws_vpc.vpc.id
#   map_public_ip_on_launch = var.map_public_ip_on_launch
#   availability_zone       = data.aws_availability_zones.available.names[2]

#   tags = local.common_tags
# }

# ROUTING #
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = local.common_tags
}

resource "aws_route_table_association" "rta" {

  count          = length(var.subnets_cidr)
  subnet_id      = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = aws_route_table.rtb.id

}

# resource "aws_route_table_association" "rta-subnet1" {
#   subnet_id      = aws_subnet.subnet.id
#   route_table_id = aws_route_table.rtb.id
# }

# resource "aws_route_table_association" "rta-subnet2" {
#   subnet_id      = aws_subnet.subnet2.id
#   route_table_id = aws_route_table.rtb.id
# }

# resource "aws_route_table_association" "rta-subnet3" {
#   subnet_id      = aws_subnet.subnet3.id
#   route_table_id = aws_route_table.rtb.id
# }

# SECURITY GROUPS #
# Apache security group 
resource "aws_security_group" "apache-sg" {
  name   = var.apache_sg_name
  vpc_id = aws_vpc.vpc.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_security_group" "lb-sg" {
  name   = var.apache_lb_sg_name
  vpc_id = aws_vpc.vpc.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}





