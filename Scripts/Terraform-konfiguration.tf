provider "aws" {
  region = "us-east-1"
}

provider "tls" {}

# Erstellen des privaten und öffentlichen Schlüssels mit dem TLS Provider
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Erstellen des Key-Pairs in AWS mit dem öffentlichen Schlüssel
resource "aws_key_pair" "private_key" {
  key_name   = "private-key"
  public_key = tls_private_key.example.public_key_openssh
}

# Erstellen des privaten Schlüssels als Datei
resource "local_file" "private_key" {
  filename = "${path.module}/private-key.pem"
  content  = tls_private_key.example.private_key_pem
}

# Erstellen der Webserver-Sicherheitsgruppe
resource "aws_security_group" "web_security_group" {
  name_prefix = "web-security-group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Erstellen der Datenbankserver-Sicherheitsgruppe
resource "aws_security_group" "db_security_group" {
  name_prefix = "db-security-group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2-Instanz für den Webserver
resource "aws_instance" "webserver" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu Version 20.04 LTS
  instance_type = "t2.micro"
  key_name      = aws_key_pair.private_key.key_name
  security_groups = [aws_security_group.web_security_group.name]
  user_data = file("Webserver.sh")
  tags = {
    Name = "WebServer"
  }
}

# EC2-Instanz für den Datenbankserver
resource "aws_instance" "database_server" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu Version 20.04 LTS
  instance_type = "t2.micro"
  key_name      = aws_key_pair.private_key.key_name
  security_groups = [aws_security_group.db_security_group.name]
  user_data = file("Datenbankserver.sh")
  tags = {
    Name = "DBServer"
  }
}

# Ausgaben der öffentlichen IP-Adressen
output "database_server_public_ip" {
  value = aws_instance.database_server.public_ip
}

output "webserver_public_ip" {
  value = aws_instance.webserver.public_ip
}
