resource "aws_key_pair" "ssh_key" {
  key_name   = var.ssh_key_name
  public_key = var.ssh_public_key
}

resource "aws_instance" "nodes" {
  ami           = var.vps_ami
  instance_type = var.vps_instance_type
  key_name      = aws_key_pair.ssh_key.key_name
  tags = {
    Name  = "${var.vps_name}-${count.index}"
    roles = jsonencode(var.vps_roles)
  }
  count = var.vps_count
  root_block_device {
    volume_size = var.vps_root_block_volume_size
  }
}

resource "aws_security_group" "vps_all" {
  name = "vps"
  ingress = [
    {
      description      = "All"
      from_port        = 0
      to_port          = 65535
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}

resource "aws_network_interface_sg_attachment" "vps_security_group_attachment" {
  security_group_id    = aws_security_group.vps_all.id
  network_interface_id = aws_instance.nodes[count.index].primary_network_interface_id
  count                = var.vps_count
}

