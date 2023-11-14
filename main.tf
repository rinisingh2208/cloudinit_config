data "cloudinit_config" "node_group" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/userdata.tpl")
  }
  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/updatingdockerconfig.sh")
  }
  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/customsysctl.sh")
  }
}
