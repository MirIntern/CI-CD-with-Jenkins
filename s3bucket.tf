resource "aws_s3_bucket" "dbBucket" {

	bucket = "db-bucket-copy-30-32143921"
	acl = "private"

	tags = {
	 Name = "Bucket for DB"
	}

}
