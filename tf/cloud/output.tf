output "ec2ipv4_1" {
  value       = aws_instance.server_1.public_ip
  description = "Ipv4"
}
