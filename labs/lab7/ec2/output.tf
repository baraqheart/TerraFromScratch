output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.web1.public_ip
}

output "web_key_path" {
  description = "this is the filename and path of the web key"
  value       = local_file.web_key.filename
}