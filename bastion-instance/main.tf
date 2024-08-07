variable "bastion_subnet_id" {}
variable "bastion_sg_id" {
  
}


resource "aws_instance" "bastion_instance" {
  ami           = "ami-04a81a99f5ec58529"  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = var.bastion_subnet_id
  security_groups = [var.bastion_sg_id]
  key_name = "java-project"
  tags = {
    Name = "bastion-instance"
  }
}