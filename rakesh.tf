provider "aws" {
  region     = "ap-south-1"
}

resource "aws_instance" "web" {
  ami                     = "ami-03cb1380eec7cc118"
  instance_type           = "t3.micro"
  subnet_id               = "subnet-0e3e677c606646bd7"
  key_name                = "rakesh_mumbai_new"
  vpc_security_group_ids  = ["sg-07b2f51f43c970c5e"]
  disable_api_termination = true
  disable_api_stop        = true
  user_data               = <<-EOF
          #!/bin/bash
          yum update -y
          yum install httpd -y
          systemctl start httpd
          systemctl enable httpd
          yum install git -y
	  git clone https://github.com/goodluck2717/goodluck.git
	  mv /goodluck/index.html /var/www/html/
          EOF


  tags = {
    Name = "HelloWorld"
  }
}


output "aws_instance_public_ip" {
  value = aws_instance.web.public_ip
}
