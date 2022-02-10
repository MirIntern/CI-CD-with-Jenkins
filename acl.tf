resource "aws_network_acl" "webServerAcl" {

	vpc_id = aws_vpc.myVPC.id
	subnet_ids = [aws_subnet.frontEndServer-a.id, aws_subnet.frontEndServer-b.id]
	egress {
	 protocol = -1
	 rule_no = 100
	 action = "allow"
	 cidr_block = "0.0.0.0/0"
	 from_port = 0
	 to_port = 0
	}
	ingress {
	 protocol = -1
	 rule_no = 100
	 action = "allow"
	 cidr_block = "0.0.0.0/0"
	 from_port = 0
	 to_port = 0
	}
}

resource "aws_network_acl" "jenkinsServerAcl" {

	vpc_id = aws_vpc.myVPC.id
	subnet_ids = [aws_subnet.backEndJenkins.id]
	egress {
	 protocol = -1
	 rule_no = 100
	 action = "allow"
	 cidr_block = "0.0.0.0/0"
	 from_port = 0
	 to_port = 0
	}
	ingress {
	 protocol = -1
	 rule_no = 100
	 action = "allow"
	 cidr_block = "0.0.0.0/0"
	 from_port = 0
	 to_port = 0
	}
}

resource "aws_network_acl" "dbServerAcl" {

	vpc_id = aws_vpc.myVPC.id
	subnet_ids = [aws_subnet.backEndDB-a.id, aws_subnet.backEndDB-b.id]
	egress {
	 protocol = -1
	 rule_no = 100
	 action = "allow"
	 cidr_block = "0.0.0.0/0"
	 from_port = 0
 	 to_port = 0
	}
	ingress {
	 protocol = -1
	 rule_no = 100
	 action = "allow"
	 cidr_block = "0.0.0.0/0"
	 from_port = 0
	 to_port = 0
	}
}
