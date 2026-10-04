output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "public_ip" {
  description = "Elastic IP of the web server"
  value       = aws_eip.web_server_eip.public_ip
}
