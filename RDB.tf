# Configure MySQL RDS Instance
#DB
resource "aws_db_instance" "P8DB" {
  allocated_storage    = 12
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "P8DB"
  username             = "Buks"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.P8DBSN.id
}


#DB Subnet
resource "aws_db_subnet_group" "P8DBSN" {
  name       = "db-subnet-grp"
  subnet_ids = [aws_subnet.DB-SN-1.id, aws_subnet.DB-SN-2.id]

  tags = {
    Name = "http"
  }
}



#DB Security Group
resource "aws_security_group" "P8-DBSG" {
  name        = "P8-DBSG"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.Project8-VPC.id
}

  resource "aws_security_group_rule" "DbSG-Inbound" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.P8-DBSG.id
}

resource "aws_security_group_rule" "DBSG-Outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.P8-DBSG.id
}
