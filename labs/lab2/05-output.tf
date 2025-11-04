output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.server.public_ip
}