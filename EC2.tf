# Configure Webserver
resource "aws_instance" "P8-WS1" {
   ami           = "ami-0ed9277fb7eb570c9"
   count = 1
   instance_type = "t2.micro"
   security_groups = [aws_security_group.P8-SG.id]
   subnet_id = aws_subnet.Web-SN-1.id
   
  }