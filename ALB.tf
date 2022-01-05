# Configure Application Load Balancer
resource "aws_lb" "P8-LB" {
  name               = "P8-Alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.P8-SG.id]
  subnets            = [aws_subnet.Web-SN-1.id, aws_subnet.Web-SN-2.id]

  enable_deletion_protection = false
}


#Configure LB Target Group
resource "aws_lb_target_group" "P8-LBTG" {
  name     = "P8-lb-TG1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Project8-VPC.id
}