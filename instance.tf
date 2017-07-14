resource "aws_instance" "A2" {
  ami           = "ami-2afbde4a"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  vpc_security_group_ids = ["${aws_security_group.MyRule1.id}"]

  tags {
    Name = "HelloWorld"
  }

  provisioner "file" {
    source      = ""${path.module}/scripts/a1.sh"
    destination = "/tmp/a1.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/a1.sh",
      "/tmp/a1.sh",
    ]
  }

connection {
  type     = "ssh"
  user     = "ubuntu"
  private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }

resource "aws_security_group" "MyRule1" {
  name        = "MyRule1"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "MyRule1"
  }
  }
}

output "instance_ips" {
  value = ["${aws_instance.A2.public_ip}"]
}
output "vpc_security_group" {
  value = ["${aws_instance.A2.vpc_security_group_ids.1251055843}"]
}
output "Instance_name" {
  value = ["${aws_instance.A2.tags.Name}"]
}
output "public_dns" {
  value = ["${aws_instance.A2.public_dns}"]
}
