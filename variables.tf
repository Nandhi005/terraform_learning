variable "app_port" {
  type = number
}
variable "region" {
  default = "ap-south-1"
}
variable "app_port_to_port" {}
variable "iam_user" {
  type    = list(any)
  default = ["raj", "hayyith"]
}
variable "ami_id" {
  type = map(any)
  default = {
    us-east-1 = "ami-0c1fe732b5494dc14"
    us-east-2 = "ami-05efc83cb5512477c"
    us-west-2 = "ami-0320940581663281e"
  }
}
variable "instance_name" {
  type    = list(any)
  default = ["functions1", "functions2"]
}
variable "sg_ports" {
  type    = list(any)
  default = [8000, 9000, 9001, 6379, 27001]
}
# variable "valid" {
#   type = string
#   validation {
#     condition = length(var.valid) >= 12
#     error_message = "the variable value length must be greater than 12"
#   }
# }
