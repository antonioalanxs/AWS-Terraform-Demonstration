resource "aws_security_group" "security_group" {
  name        = "security_group"
  description = "Allow inbound traffic on port 3000"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instance" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.security_group.name]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = var.name
  }
}
