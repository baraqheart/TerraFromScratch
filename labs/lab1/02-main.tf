// create instance
resource "aws_instance" "example" {
  ami           = ""
  instance_type = "t3.micro"

  tags = {
    Name = "my-server"
  }
}