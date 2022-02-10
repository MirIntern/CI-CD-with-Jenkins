data "aws_ami" "amazonLinux" {
	owners = ["amazon"]
	most_recent = true
	
	filter {
	 name = "name"
	 values = ["amzn2-ami-hvm-*-x86_64-ebs"]
	}
}


resource "aws_launch_template" "t2microTemplateServ" {
	image_id = data.aws_ami.amazonLinux.id
	instance_type = "t2.micro"
	network_interfaces {
	 associate_public_ip_address = true
	 security_groups = [aws_security_group.allowPort80Ingress.id, aws_security_group.inboundFromALB.id, aws_security_group.webServer.id, aws_security_group.allowAllEgress.id, aws_security_group.sshAccess.id, aws_security_group.outboundFromWebServer.id]
	}
	key_name = "LoadBalancerPublic2"
}

resource "aws_launch_template" "t2microTemplateJenk" {
	image_id = data.aws_ami.amazonLinux.id
	instance_type = "t2.micro"
	network_interfaces {
	 associate_public_ip_address = true
	 security_groups = [aws_security_group.allowPort80Ingress.id, aws_security_group.allowPort8080Ingress.id, aws_security_group.allowAllEgress.id, aws_security_group.sshAccess.id]
	}
	key_name = "LoadBalancerPublic2"
}

resource "aws_autoscaling_group" "frontEndServerScaleGrp" {
	desired_capacity = 1
	max_size = 1
	min_size = 1

	launch_template {
	 id = aws_launch_template.t2microTemplateServ.id
	 version = "$Latest"
	}
	vpc_zone_identifier = [aws_subnet.frontEndServer-a.id, aws_subnet.frontEndServer-b.id]
}

resource "aws_autoscaling_group" "jenkinsServerScaleGrp" {
	desired_capacity = 1
	max_size = 1
	min_size = 1

	launch_template {
	 id = aws_launch_template.t2microTemplateJenk.id
	 version = "$Latest"
	}

	vpc_zone_identifier = [aws_subnet.backEndJenkins.id]
}