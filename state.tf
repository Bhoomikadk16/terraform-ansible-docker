provider "aws" {
  region     = "ap-south-1"
}

resource "aws_security_group" "worker_sg" {
  tags = {
    name = "worker_sg"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}
resource "aws_instance" "worker_node" {
  ami             = "ami-0f2ce9ce760bd7133"
  instance_type   = "t2.micro"
  key_name        = "bhoom"
  security_groups = [aws_security_group.worker_sg.name]
  count           = "2"
  tags = {
    Name = "worker_node"
  }
  user_data = file("./ansible.sh")
}


output "private_ip" {
  value = aws_instance.worker_node.*.private_ip
}