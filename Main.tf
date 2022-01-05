# Configure the Virtual Private Cloud

resource "aws_vpc" "Project8-VPC" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
      Name = "Project8-VPC"
  }
}

# Configure the Web-Subnet
resource "aws_subnet" "Web-SN-1" {
  vpc_id     = aws_vpc.Project8-VPC.id
  cidr_block = "10.0.0.0/24"
   availability_zone = "us-east-1a"

  tags = {
    Name = "Web-SN-1"
  }
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "Web-SN-2" {
  vpc_id     = aws_vpc.Project8-VPC.id
  cidr_block = "10.0.1.0/24"
   availability_zone = "us-east-1b"

  tags = {
    Name = "Web-SN-1"
  }
  map_public_ip_on_launch = "true"
}

# Configure the Application-Subnet
resource "aws_subnet" "App-SN-1" {
  vpc_id     = aws_vpc.Project8-VPC.id
  cidr_block = "10.0.2.0/24"
   availability_zone = "us-east-1c"

  tags = {
    Name = "App-SN-1"
  }
}

resource "aws_subnet" "App-SN-2" {
  vpc_id     = aws_vpc.Project8-VPC.id
  cidr_block = "10.0.3.0/24"
   availability_zone = "us-east-1d"

  tags = {
    Name = "App-SN-2"
  }
}

# Configure the Database-Subnet
resource "aws_subnet" "DB-SN-1" {
  vpc_id     = aws_vpc.Project8-VPC.id
  cidr_block = "10.0.4.0/24"
   availability_zone = "us-east-1e"

  tags = {
    Name = "DB-SN-1"
  }
}

resource "aws_subnet" "DB-SN-2" {
  vpc_id     = aws_vpc.Project8-VPC.id
  cidr_block = "10.0.5.0/24"
   availability_zone = "us-east-1f"

  tags = {
    Name = "DB-SN-2"
  }
}
# Configure Internet Gateway
resource "aws_internet_gateway" "P8-IGW" {
  vpc_id = aws_vpc.Project8-VPC.id

  tags = {
    Name = "P8-IGW"
  }
}

# Configure Route Table - Public
resource "aws_route_table" "P8-RT" {
  vpc_id = aws_vpc.Project8-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.P8-IGW.id
  }
 }

# Configure Route Table - Private
resource "aws_route_table" "P8-PriRT" {
  vpc_id = aws_vpc.Project8-VPC.id

  route = []

  tags = {
    Name = "P8-PriRT"
  }
}

 # Configure Web SN with RT Association
 resource "aws_route_table_association" "P8-RA-WSN1" {
  subnet_id      = aws_subnet.Web-SN-1.id
  route_table_id = aws_route_table.P8-RT.id
}

 resource "aws_route_table_association" "P8-RA-WSN2" {
  subnet_id      = aws_subnet.Web-SN-2.id
  route_table_id = aws_route_table.P8-RT.id
}

# Configure Internet Gateway Association with RT

 resource "aws_route" "IGW-ass-pub-RT" {
  route_table_id            = aws_route_table.P8-RT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.P8-IGW.id
 
}



 #Configure Web Server
