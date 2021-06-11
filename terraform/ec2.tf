resource "aws_instance" "acgecc-devec2" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"

    # VPC
    subnet_id = "${aws_subnet.pubsubnet.id}"

    # Security Group
    vpc_security_group_ids = ["${aws_security_group.default.id}"]

    # the Public SSH key
    key_name = "${aws_key_pair.kpacgecc.id}"

    # nginx installation
    provisioner "file" {
        source = "userdata.sh"
        destination = "/tmp/userdata.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/userdata.sh",
            "sudo /tmp/userdata.sh"
        ]
    }

    connection {
        user = "${var.EC2_USER}"
        host = self.public_ip
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
    }
      tags = {
    Name = "acgecc-devec2"
  }
}

resource "aws_key_pair" "kpacgecc" {
    key_name = "kpacgecc"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}
