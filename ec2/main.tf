#Step 1 - Create VPC
resource "aws_vpc" "DMZ" {
  cidr_block = "10.254.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support= true

  tags = {
    Name = "DMZ Network"
  }
}

#Step 2 - Create Internet Gateway (IGW)
resource "aws_internet_gateway" "DMZ_IGW" {
  vpc_id = aws_vpc.DMZ.id

  tags = {
    Name = "IGW for DMZ Network"
  }
}

#Step 3 - Create custom route table 
resource "aws_route_table" "DMZ_routing-table" {
  vpc_id = aws_vpc.DMZ.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.DMZ_IGW.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id             = aws_internet_gateway.DMZ_IGW.id
  }

  tags = {
    Name = "DMZ routing table"
  }
}

#Step 4 - Create a Subnet
resource "aws_subnet" "DMZ-Subnet-AIOServers" {
  vpc_id = aws_vpc.DMZ.id
  cidr_block = "10.254.254.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "DMZ All in one Servers subnet"
  }
}

#Step 5 - Associate subnet with route table
resource "aws_route_table_association" "DMZ_AIOServers-to-DMZ_routing_table" {
  subnet_id      = aws_subnet.DMZ-Subnet-AIOServers.id
  route_table_id = aws_route_table.DMZ_routing-table.id
}

#Step 6 - Security group
resource "aws_security_group" "DMZ_AIOServers-SecurityGroup" {
  name        = "AIOServers-SecurityGroup"
  description = "Allows 22, 80 and 443"
  vpc_id      = aws_vpc.DMZ.id

  ingress {
    description = "HTTPS Traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DMZ-AIOServers_Allow22-80-443"
  }
}

#Step 7 - Create NIC with an IP in the subnet created in Step 4
resource "aws_network_interface" "DMZ-Server-NIC" {
  subnet_id       = aws_subnet.DMZ-Subnet-AIOServers.id
  private_ips     = ["10.254.254.254"]
  security_groups = [aws_security_group.DMZ_AIOServers-SecurityGroup.id]
}

#Step 8 - Assign an elastic IP to the network interface create in Step 7 (public IPV4 address)
resource "aws_eip" "DMZ-Server-EIP" {
  domain                    = "vpc"
  instance                  = aws_instance.DMZ-Server-instance.id
  #network_interface         = aws_network_interface.DMZ-Server-NIC.id
  #associate_with_private_ip = "10.254.254.254"
  #depends_on                = [aws_internet_gateway.DMZ_IGW]
}

#Step 9 - Create an Ubuntu server 
resource "aws_instance" "DMZ-Server-instance" {
  ami               = var.ami_system
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  key_name          = var.ssh_key

  network_interface {
    device_index         = 0 
    network_interface_id = aws_network_interface.DMZ-Server-NIC.id
  }

  user_data  = <<-EOF
               #!/bin/bash 
               sudo apt update -y
               sudo apt install apache2 -y
               sudo systemctl start apache2
               sudo bash -c 'echo "1st web server deployed with Terraform/AWS" > /var/www/html/index.html'
               EOF

  depends_on = [aws_route_table_association.DMZ_AIOServers-to-DMZ_routing_table]

  tags = {
    name = "Webserver01"
  }
}
