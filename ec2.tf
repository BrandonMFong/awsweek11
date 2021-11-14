# EC2
/* resource "aws_instance" "week11-bastion-vm" {
  ami           = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.week11-sub-b.id

  vpc_security_group_ids = [
    aws_security_group.week11-ssh-sg-v2.id
  ]

  key_name = "ECE592"

  tags = {
    Name = "week11-bastion-vm"
  }
}*/

# worker vm
resource "aws_instance" "week11-worker-vm" {
  ami                  = "ami-0168b9285893a7395"
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.week11-pri-a.id
  iam_instance_profile = aws_iam_instance_profile.week11-profile-ref.name

  vpc_security_group_ids = [
    aws_security_group.week11-ssh-pri-sg.id
  ]

  key_name = "ECE592"

  user_data = file("cloudinit.txt")

  tags = {
    Name = "week11-worker-vm"
  }
}

# IAM profile ref
resource "aws_iam_instance_profile" "week11-profile-ref" {
  name = "week11-profile-ref"
  role = aws_iam_role.week11-role.name
  tags = {
    Name = "week11-profile-ref"
  }
}
