#Step 1 - Create VPC
resource "aws_vpc" "rds_vpc" {
  cidr_block = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support= true

  tags = {
    Name = "RDS Network"
  }
}

#Step 2 - Create private subnets
resource "aws_subnet" "psubnet_1a" {
  cidr_block              = "192.168.111.0/24"
  vpc_id                  = aws_vpc.rds_vpc.id
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "psubnet_1a"
  }
}

resource "aws_subnet" "psubnet_1b" {
  cidr_block              = "192.168.222.0/24"
  vpc_id                  = aws_vpc.rds_vpc.id
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "psubnet_1b"
  }
}

#Step 3 - Configure Security Group for RDS
resource "aws_security_group" "rds_security_group" {
  name        = "rds_security_group"
  description = "Allow inbound traffic only for MYSQL and all outbound traffic"
  vpc_id      = aws_vpc.rds_vpc.id
  tags = {
    Name = "RDS_security_group"
  }
}

resource "aws_vpc_security_group_egress_rule" "rds_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.rds_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "rds_allow_http_ipv4" {
  security_group_id = aws_security_group.rds_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

#Step 4 - Define AWS RDS Subnets
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnets"
  subnet_ids = [aws_subnet.psubnet_1a.id, aws_subnet.psubnet_1b.id]
  tags = {
    Name = "RDS Subnets"
  }
}

#Step 5 - Create an DB parameter group
resource "aws_db_parameter_group" "rds_parameter_group" {
  name   = "rds-pg"
  family = "mysql8.4"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

}

#Step 6 - Create an RDS instance
resource "aws_db_instance" "rds_instance" {
  allocated_storage      = 10
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "8.4.4"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "password123"
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  db_subnet_group_name   = "rds_subnets"
  parameter_group_name   = aws_db_parameter_group.rds_parameter_group.name
  skip_final_snapshot    = true
}
