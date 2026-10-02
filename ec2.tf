resource "aws_instance" "web_server" {
  ami                    = "ami-0aba19e56f3eaec05"
  instance_type          = "t3.micro"
  key_name               = "my-first-key"
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]

  tags = {
    Name = "my-first-server"
  }
}

resource "aws_eip" "web_server_eip" {
  instance = aws_instance.web_server.id
  domain   = "vpc"

  tags = {
    Name = "web-server-eip"
  }
}
