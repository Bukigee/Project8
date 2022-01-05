# Configure Security Group
resource "aws_security_group" "P8-SG" {
  name        = "P8-SG"
  description = "HTTP access"
  vpc_id      = aws_vpc.Project8-VPC.id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    
  }

  tags = {
    Name = "P8-SG"
  }
}