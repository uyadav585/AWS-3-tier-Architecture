resource "aws_eip" "elastic-ip" {
  
  domain = "vpc"
}

output "allocation_id" {
  value = aws_eip.elastic-ip.id
}