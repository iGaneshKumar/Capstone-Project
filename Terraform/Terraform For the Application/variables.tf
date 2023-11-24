variable "ec2" {
  type    = list(string)
  default = ["ami-0287a05f0ef0e9d9a", "t2.micro", "default"]
}

variable "key" {
  type    = string
  default = "test"
}