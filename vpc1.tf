# Create a VPC

resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc-cidr}"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Test VPC"
  }
   
}

# Create Internet Gateway and attach to vpc
# terraform aws create internet gateway 

resource "aws_internet_gateway" "internet-gateway"{
    
    vpc_id = aws_vpc.vpc.id
    tags    ={
       Name = "Test IGW"
    }

}

# create public subnet 1
# terraform aws create subnet

resource "aws_subnet" "public-subnet-1" {
    vpc_id  = aws_vpc.vpc.id
    cidr_block = "${var.public-subnet-1-cidr}"
    availability_zone = "eu-central-1aa"

    tags  = {
        Name = "public subnet 1"
    }
}  

# create public subnet 2
# terraform aws create subnet

resource "aws_subnet" "public-subnet-2" {
    vpc_id  = aws_vpc.vpc.id
    cidr_block = "${var.public-subnet-2-cidr}"
    availability_zone = "eu-central-1a"

    tags  = {
        Name = "public subnet 2"
    }
}  

# create Route table and add public Route
# terraform aws create route table

resource "aws_route_table" "public-route-table" {

 vpc_id  = aws_vpc.vpc.id
 
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
 }
 tags = {
    Name = "Public Route Table"
   }
 }
# Associate Public Subnet1 to "Public Route Table"
# terraform aws Associate subnetwith route table.

resource "aws_route_table_association" "public-subnet-11-route-table-association" {
    subnet_id  = aws_subnet.public-subnet-1.id
    route_table_id = aws_route_table.public-route-table.id
}

# Associate Public Subnet2 to "Public Route Table"
# terraform aws Associate subnetwith route table.

resource "aws_route_table_association" "public-subnet-2-route-table-association" {
    subnet_id  = aws_subnet.public-subnet-2.id
    route_table_id = aws_route_table.public-route-table.id
}

# create private subnet 1
# terraform aws create subnet

resource "aws_subnet" "private-subnet-1" {
    vpc_id  = aws_vpc.vpc.id
    cidr_block = "${var.private-subnet-1-cidr}"
    availability_zone = "eu-central-1a"

    tags  = {
        Name = "private subnet 1 | App Tier"
    }
} 

# create private subnet 2
# terraform aws create subnet

resource "aws_subnet" "private-subnet-2" {
    vpc_id  = aws_vpc.vpc.id
    cidr_block = "${var.private-subnet-2-cidr}"
    availability_zone = "eu-central-1a"

    tags  = {
        Name = "private subnet 2 | App Tier"
    }
} 
# create private subnet 3
# terraform aws create subnet

resource "aws_subnet" "private-subnet-3" {
    vpc_id  = aws_vpc.vpc.id
    cidr_block = "${var.private-subnet-3-cidr}"
    availability_zone = "eu-central-1a"
   
    tags  = {
        Name = "private subnet 3 | Database Tier"
    }
} 
# create private subnet 4
# terraform aws create subnet

resource "aws_subnet" "private-subnet-4" {
    vpc_id  = aws_vpc.vpc.id
    cidr_block = "${var.private-subnet-4-cidr}"
    availability_zone = "eu-central-1a"
    
    tags  = {
        Name = "private subnet 4 | Database Tier"
    }
} 