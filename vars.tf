variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-04a81a99f5ec58529"
    #eu-west-1  = "ami-0333305f9719618c7"
    #ap-south-1 = "ami-06984ea821ac0a879"
  }
}

variable "subnet" {
  default = "public"
}

variable "instance_type" {
  type        = string
  default     = "t2.medium"
  description = "description"
}

/*variable "ecrrepo" {
  type    = string
  default = "techieirfan-repo"
}*/


