variable "my_vpc_cidr" {}
variable "my_subnet_cidr" {}
variable "my_datacentre" {}
variable "my_rt_cidr" {}

resource "aws_vpc" "myownvpc" {
  cidr_block       = var.my_vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "addy_vpc"
  }
}
resource "aws_subnet" "publicsubnet" {
  depends_on = [ aws_vpc.myownvpc]
  
  vpc_id     = aws_vpc.myownvpc.id
  cidr_block = var.my_subnet_cidr
  availability_zone = var.my_datacentre
  map_public_ip_on_launch = true
  tags = {
    Name = "addy_subnet"
  }
}
resource "aws_internet_gateway" "myigw" {
  depends_on = [ aws_vpc.myownvpc ]

  vpc_id = aws_vpc.myownvpc.id
  tags = {
    Name = "addy_igw"
  }
}

resource "aws_route_table" "rt" {
  
  depends_on = [ aws_internet_gateway.myigw ]
  
  vpc_id = aws_vpc.myownvpc.id
  route {
    cidr_block = var.my_rt_cidr
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "addyroute_table"
  }
}


resource "aws_route_table_association" "rt_association" {
  
  depends_on = [ aws_route_table.rt ]

  subnet_id      = aws_subnet.publicsubnet.id
  route_table_id = aws_route_table.rt.id
}