
// PRIMARY VPC
resource "aws_vpc" "dev-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #gives you an internal host name
    enable_classiclink = "false"
    instance_tenancy = "default"    
    
    tags = {
        Name = "dev-vpc"
    }
}

// PUBLIC SUBNET
resource "aws_subnet" "pubsubnet" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Pub-Subnet"
    }
}

// PRIVATE SUBNET
resource "aws_subnet" "privsubnet" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Priv-Subnet"
    }
}

// DATA SUBNET 1
resource "aws_subnet" "datasubnet" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Data-Subnet1"
    }
}

resource "aws_subnet" "datasubnet2" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"
    tags = {
        Name = "Data-Subnet2"
    }
}