
resource "aws_db_subnet_group" "dbSubnet" {
	subnet_ids = [aws_subnet.backEndDB-a.id, aws_subnet.backEndDB-b.id]
}

resource "aws_db_instance" "backEndMySql" {
	allocated_storage = 20
	max_allocated_storage = 21
	engine = "mysql"
	engine_version = "8.0"
	instance_class = "db.t2.micro"
	name = "mydb"
	username = "root"
	password = "password"
	identifier = "myrdsdb"
	db_subnet_group_name = aws_db_subnet_group.dbSubnet.id		
	vpc_security_group_ids = [aws_security_group.database.id, aws_security_group.outboundFromDB.id, aws_security_group.inboundToDB.id]
	skip_final_snapshot = true
}
