data "cloudinit_config" "node_group" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/userdata.tpl")
  }

}

resource "aws_launch_template" "eks_launch_template" {

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.node_disk_size
    }
  }
  key_name = var.ec2_ssh_key
  network_interfaces {
    associate_public_ip_address = false

  }

  user_data = base64encode(data.cloudinit_config.node_group.rendered)

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "EKS-MANAGED-NODE"
    }
  }
