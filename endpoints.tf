# Security Group
resource "aws_security_group" "week11-https-sg" {
  name        = "week11-https-sg"
  description = "Week10 endpoints tf"
  vpc_id      = aws_vpc.week11-vpc.id

  ingress = [{
    description = "SSH from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = []

    # Suggested by professor
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = [aws_security_group.week11-ssh-pri-sg.id]
    self             = false
  }]

  egress = [{
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    # Suggested
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]

  tags = {
    Name = "week11-ssh-pri-sg"
  }
}

# EC2
resource "aws_vpc_endpoint" "week11-ec2-ep" {
  vpc_id            = aws_vpc.week11-vpc.id
  service_name      = "com.amazonaws.us-east-1.ec2"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.week11-pri-a.id, aws_subnet.week11-pri-b.id]

  security_group_ids = [
    aws_security_group.week11-https-sg.id,
  ]

  private_dns_enabled = true

  tags = {
    Environment = "EC2 Endpoint"
  }
}

# SQS
resource "aws_vpc_endpoint" "week11-sqs-ep" {
  vpc_id            = aws_vpc.week11-vpc.id
  service_name      = "com.amazonaws.us-east-1.sqs"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.week11-pri-a.id, aws_subnet.week11-pri-b.id]

  security_group_ids = [
    aws_security_group.week11-https-sg.id,
  ]

  private_dns_enabled = true

  tags = {
    Environment = "SQS Endpoint"
  }
}

