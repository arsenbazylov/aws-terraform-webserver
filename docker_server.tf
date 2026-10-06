resource "aws_instance" "docker_test" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io docker-compose-v2
    systemctl enable --now docker
    mkdir -p /opt/app
    cat > /opt/app/docker-compose.yml << 'COMPOSE'
    ${indent(4, file("${path.module}/docker/docker-compose.yml"))}
    COMPOSE
    cd /opt/app && docker compose up -d
  EOF

  tags = {
    Name = "docker-test-server"
  }
}

output "docker_test_ip" {
  description = "Public IP of the Docker test server"
  value       = aws_instance.docker_test.public_ip
}
