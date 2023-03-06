resource "aws_security_group" "test" {
  name        = "Terratest"
  description = "Test SG for Terratest"
  vpc_id      = data.aws_vpc.shared.id
  ingress {
    from_port        = 0
    to_port          = 6000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "test"
  }
}

data "aws_subnet" "private_subnets_a" {
  vpc_id = data.aws_vpc.shared.id
  tags = {
    "Name" = "platforms-test-general-public-eu-west-2a"
  }
}