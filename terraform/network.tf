
// INTERNET GATEWAY SETUP
resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    tags = {
        Name = "igw"
    }
}

// ROUTE TABLE FOR PUBLIC
resource "aws_route_table" "pubrt" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = "${aws_internet_gateway.igw.id}" 
    }
    tags = {
        Name = "pub-rt"
    }
}

resource "aws_route_table_association" "pubsubnetrt"{
    subnet_id = "${aws_subnet.pubsubnet.id}"
    route_table_id = "${aws_route_table.pubrt.id}"
}

// ROUTE TABLE FOR PRIVATE SUBNET
resource "aws_route_table" "privrt" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    tags = {
        Name = "priv-rt"
    }
}

resource "aws_route_table_association" "privsubnetrt"{
    subnet_id = "${aws_subnet.privsubnet.id}"
    route_table_id = "${aws_route_table.privrt.id}"
}

// ROUTE TABLE FOR DATA SUBNET
resource "aws_route_table" "datart" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    tags = {
        Name = "data-rt"
    }
}

resource "aws_route_table_association" "datasubnetrt" {
    subnet_id = "${aws_subnet.datasubnet.id}"
    route_table_id = "${aws_route_table.datart.id}"
}

resource "aws_route_table_association" "datasubnetrt2" {
    subnet_id = "${aws_subnet.datasubnet2.id}"
    route_table_id = "${aws_route_table.datart.id}"
}

// SECURITY GROUPS
resource "aws_security_group" "default" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    description = "EC2 Security Group"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.PRIVIP}"]
    } 
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }    

    ingress {
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = ["10.0.2.0/24"]
    }
    ingress {
        from_port = 6379
        to_port = 6379
        protocol = "tcp"
        cidr_blocks = ["10.0.2.0/24"]
    }

    tags = {
        Name = "ec2-SG"
    }
}

resource "aws_security_group" "db-sg" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    description = "Database Security Group"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["10.0.1.0/24"]
    }
    tags = {
        Name = "db-sg"
    }
}

resource "aws_security_group" "redis-sg" {
    vpc_id = "${aws_vpc.dev-vpc.id}"
    description = "Redis Security Group"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = ["10.0.1.184/32"]
    }

    ingress {
        from_port = 6379
        to_port = 6379
        protocol = "tcp"
        cidr_blocks = ["10.0.1.184/32"]
    }
    tags = {
        Name = "redis-sg"
    }
}