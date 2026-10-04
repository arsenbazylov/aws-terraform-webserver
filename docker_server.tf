resource "aws_instance" "docker_test" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io
    systemctl enable --now docker
    docker run -d --name my-nginx-container --restart unless-stopped -p 80:80 nginx
  EOF

  tags = {
    Name = "docker-test-server"
  }
}

output "docker_test_ip" {
  description = "Public IP of the Docker test server"
  value       = aws_instance.docker_test.public_ip
}
