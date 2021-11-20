packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "trackify" {
  ami_name = "trackify-app-${local.timestamp}"

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-2.*.1-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  #source_ami = "ami-013a129d325529d4d"


  instance_type = "t2.micro"
  region = "us-east-1"
  ssh_username = "ec2-user"
}

build {
  sources = [
    "source.amazon-ebs.trackify"
  ]

  provisioner "file" {
    source = "./trackify.service"
    destination = "/tmp/trackify.service"
  }

  provisioner "shell" {
    script = "./app.sh"
  }
}