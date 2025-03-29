#Elastic IP's Outputs
output "instance_id" {
  value       = aws_instance.DMZ-Server-instance.id
  description = "AWS ec2 instance ID"
  sensitive   = false
}

#Elastic IP's Outputs
output "eip_id" {
  value       = aws_eip.DMZ-Server-EIP.id
  description = "EIP Allocation id"
  sensitive   = false
}

output "eip_public_ip" {
  value       = aws_eip.DMZ-Server-EIP.public_ip
  description = "EIP Public IP address"
  sensitive   = false
}

output "eip_public_DNS" {
  value       = aws_eip.DMZ-Server-EIP.public_dns
  description = "EIP Public DNS"
  sensitive   = false
}
