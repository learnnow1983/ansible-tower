output "instance_public_ip" {
    value = "${ aws_instance.tower_inst.*.public_ip}"
    description = "Public ip for the Tower instance"
}