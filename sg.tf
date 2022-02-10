resource "aws_security_group" "allowPort80Ingress" {  

	vpc_id = aws_vpc.myVPC.id

	ingress {
	 from_port = 80
	 to_port = 80
	 protocol = "tcp"
	 cidr_blocks = ["0.0.0.0/0"]
	}

}

resource "aws_security_group" "allowPort8080Ingress" {

	vpc_id = aws_vpc.myVPC.id

	ingress {
	 from_port = 8080
	 to_port = 8080
	 protocol = "tcp"
	 cidr_blocks = ["0.0.0.0/0"]
	}

}

resource "aws_security_group" "allowAllIngress" {

	vpc_id = aws_vpc.myVPC.id

	ingress {
	 from_port = 0
	 to_port = 0
	 protocol = -1
	 cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_security_group" "allowAllEgress" {

	vpc_id = aws_vpc.myVPC.id

	egress {
	 from_port = 0
	 to_port = 0
	 protocol = -1
	 cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_security_group" "inboundToDB" {

	vpc_id = aws_vpc.myVPC.id

	ingress {
	 from_port = 3306
	 to_port = 3306
	 protocol = "tcp"
	 security_groups = [aws_security_group.webServer.id, aws_security_group.jenkins.id ]
	}
}

resource "aws_security_group" "outboundFromDB" {

	vpc_id = aws_vpc.myVPC.id

	egress {
	 from_port = 3306
	 to_port = 3306
	 protocol = "tcp"
	 security_groups = [aws_security_group.webServer.id]
	}
}

resource "aws_security_group" "inboundFromALB" {

	vpc_id = aws_vpc.myVPC.id

	ingress {
	 from_port = 80
	 to_port = 80
	 protocol = "tcp"
	 security_groups = [aws_security_group.outboundFromALB.id]
	}

}

resource "aws_security_group" "outboundFromALB" {

	vpc_id = aws_vpc.myVPC.id

	egress {
	 from_port = 80
	 to_port = 80
	 protocol = "tcp"
	 security_groups = [aws_security_group.webServer.id]
	}

}

resource "aws_security_group" "outboundFromWebServer" {

	vpc_id = aws_vpc.myVPC.id

	egress {
	 from_port = 3306
	 to_port = 3306
	 protocol = "tcp"
	 security_groups = [aws_security_group.database.id]
	}

}


resource "aws_security_group" "webServer" {

	vpc_id = aws_vpc.myVPC.id

}

resource "aws_security_group" "database" {

	vpc_id = aws_vpc.myVPC.id

}

resource "aws_security_group" "jenkins" {

	vpc_id = aws_vpc.myVPC.id

}


resource "aws_security_group" "sshAccess" {

	vpc_id = aws_vpc.myVPC.id

	ingress {
	 from_port = 22
	 to_port = 22
	 protocol = "tcp"
	 cidr_blocks = ["0.0.0.0/0"]
	}

}
