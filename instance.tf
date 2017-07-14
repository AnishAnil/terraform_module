resource "aws_instance" "A2" {
  ami           = "ami-2afbde4a"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  vpc_security_group_ids = ["${aws_security_group.MyRule1.id}"]

  tags {
    Name = "HelloWorld"
  }

  provisioner "file" {
    source      = "${path.module}/scripts/a1.sh"
    destination = "/tmp/a1.sh"
  }
}
  
