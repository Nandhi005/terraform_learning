provider "aws" {
  region = var.region
}

data "aws_ami" "example" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}
check "ami"{
assert {
  condition= data.aws_ami.example.image_id == ""
  error_message="The ami is not present"
}
}
resource "aws_instance" "example" {
  ami           = data.aws_ami.example.image_id
  instance_type = "t2.micro"
  key_name = "Jenkins_server"
  vpc_security_group_ids = ["sg-0031387a79189a0eb"]
   connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./Jenkins_server.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
  inline = [
    "sudo yum install nginx -y",
    "sudo systemctl start nginx"
  ]
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> server_public.txt"
    when = destroy
  }
}