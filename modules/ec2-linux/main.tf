resource "aws_security_group" "security_group" {
  name   = "EC2-SecurityGroup"
  vpc_id = var.vpc_id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.prefix}_EC2-SecurityGroup"
  }
}

resource "aws_instance" "ec2-instance" {
  ami                    = var.amiid
  instance_type          = var.size
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.security_group.id]

  root_block_device {
    volume_size = "100"
  }

  user_data = templatefile("./modules/ec2-linux/create_machine_script.tmpl", {})

  iam_instance_profile = null

  tags = {
    Name = "${local.prefix}_${var.ec2name}"
  }
}

locals {
  prefix = "peinfra"
}
