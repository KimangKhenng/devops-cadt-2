resource "aws_security_group" "sg_1" {
  name = "default"

  ingress {
    description = "App Port"
    from_port   = 8000
    to_port     = 8000
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

resource "aws_key_pair" "kkk3_key" {
  key_name   = "kkk3-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCraET6lYDr5rSnxNH6eQODdBd4hIUjJ1pcyF/WDUft5jSR9iMq9PXJ5g6WdV7XNEOS9GK2liPqHiwglVZOTFjxno5Xf4CsNdqlsgM+paJplE9w4LR9yW/S8IzQaLjpMrvzQQTl+CffBfpxkezDmaU6IpTpf4Z9Yludx2A97IE57GUH/irY85+3uLlwM/CskFeBTwAek3vkgdtTjt0fLcuTIjfb/O2gr0opyz7wiiWJC3iN+nM1LS38D2gm2ji8BpZVhejap08zOIS0xwKSLfYmQIDjsiaQu5hGDMnO4ALZI8++p2E5VPgns2e7GNJYha6FNhD1ckijY4yCs1qpzY2F kimang@KIMs-MacBook-Pro.local"
}

resource "aws_instance" "server_1" {
  ami                         = "ami-ff0fea8310f3"
  instance_type               = "t3.micro"
  count                       = 2
  key_name                    = aws_key_pair.kkk3_key.key_name
  security_groups             = [aws_security_group.sg_1.name]
  user_data                   = <<-EOF
              #!/bin/bash
              apt update
              apt install python3 -y
            EOF
  user_data_replace_on_change = true
}