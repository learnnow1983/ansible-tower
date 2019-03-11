##Tower server

##keypair

resource "aws_key_pair" "gk_auth" {
    key_name = "${var.key_name}"
    public_key = "${file(var.public_key_path)}"
}

#Instance-creation

resource "aws_instance" "tower_inst" {
    instance_type = "${var.instance_type}"
    ami = "${var.instance_ami}"
    root_block_device{
        volume_size = "20"
        volume_type = "gp2"
    }

    ebs_block_device {
    device_name           = "/dev/sdg"
    volume_type           = "gp2"
    volume_size           = 40
    delete_on_termination = true
    }

   user_data = "${file(var.script_path)}}"
    

    tags {
        Name = "Ansible-Tower-GK"
    }

    key_name = "${aws_key_pair.gk_auth.id}"
    vpc_security_group_ids = ["${aws_security_group.tower_sg.id}"]
    subnet_id = "${aws_subnet.tower_pub_subnet.id}"

}