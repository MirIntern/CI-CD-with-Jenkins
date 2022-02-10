resource "aws_route_table" "frontEndRouteTable" {
	vpc_id = aws_vpc.myVPC.id
	
	route {
	 cidr_block = "0.0.0.0/0"
	 gateway_id = aws_internet_gateway.igwFrontEnd.id
	}

}

resource "aws_route_table" "jenkinsRouteTable" {

	vpc_id = aws_vpc.myVPC.id
	
	route {
	 cidr_block = "0.0.0.0/0"
	 gateway_id = aws_internet_gateway.igwFrontEnd.id
	}	
}


resource "aws_route_table" "dbRouteTable" {

	vpc_id = aws_vpc.myVPC.id
	
}

resource "aws_route_table_association" "dbRTbSub" {

	subnet_id = aws_subnet.backEndDB-b.id
	route_table_id = aws_route_table.dbRouteTable.id
}


resource "aws_route_table_association" "dbRTSub" {

	subnet_id = aws_subnet.backEndDB-a.id
	route_table_id = aws_route_table.dbRouteTable.id
}

resource "aws_route_table_association" "webRTbSub" {

	subnet_id = aws_subnet.frontEndServer-b.id
	route_table_id = aws_route_table.frontEndRouteTable.id
}


resource "aws_route_table_association" "webRTSub" {

	subnet_id = aws_subnet.frontEndServer-a.id
	route_table_id = aws_route_table.frontEndRouteTable.id
}

resource "aws_route_table_association" "jenkRTSub" {

	subnet_id = aws_subnet.backEndJenkins.id
	route_table_id = aws_route_table.jenkinsRouteTable.id
}

