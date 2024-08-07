variable "public_subnet_id" {}
variable "allocation_id" {}






resource "aws_nat_gateway" "nat" {
  subnet_id = var.public_subnet_id
  connectivity_type = "public"
  allocation_id = var.allocation_id

  tags = {
    Name = "nat-gateway"
  }
}

output "nat_id" {
  value = aws_nat_gateway.nat.id
}