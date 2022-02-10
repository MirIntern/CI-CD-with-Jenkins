resource "aws_lb_target_group" "awsAlbTg" {
	port = 80
	protocol = "HTTP"
	vpc_id = aws_vpc.myVPC.id

}

resource "aws_autoscaling_attachment" "asgTgAttachment" {

	autoscaling_group_name = aws_autoscaling_group.frontEndServerScaleGrp.id
	alb_target_group_arn = aws_lb_target_group.awsAlbTg.arn

}

resource "aws_lb" "awsAlb" {

	internal = false
	load_balancer_type = "application"
	security_groups = [aws_security_group.outboundFromALB.id, aws_security_group.allowAllIngress.id]
	subnets = [aws_subnet.frontEndServer-a.id, aws_subnet.frontEndServer-b.id]	

}

resource "aws_lb_listener" "awsAlbListener" {
	load_balancer_arn = aws_lb.awsAlb.arn
	port = 80
	protocol = "HTTP"

	default_action {
	 type = "forward"
	 target_group_arn = aws_lb_target_group.awsAlbTg.arn
	}
}
