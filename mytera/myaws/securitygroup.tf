variable "my_sg_cidr" {}
variable "my_sg_protocol" {}

resource "aws_security_group" "mywebsg" {
  name = "allow_nfs"
  vpc_id = aws_vpc.myownvpc.id
  
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = var.my_sg_protocol
    cidr_blocks = [var.my_sg_cidr]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = var.my_sg_protocol
    cidr_blocks = [var.my_sg_cidr]
  }
  ingress {
    description = "NFS"
    from_port   = 2049
    to_port     = 2049
    protocol    = var.my_sg_protocol
    cidr_blocks = [var.my_sg_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks =  [var.my_sg_cidr]
  }
  
  tags = {
    Name = "myweb_sg"
  }
}