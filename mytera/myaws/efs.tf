variable "my_efs_token" {}
variable "my_efs_encryption" {}

resource "aws_efs_file_system" "myefsvol" {
  creation_token = var.my_efs_token
  encrypted = var.my_efs_encryption
  tags = {
    Name = "MY_EFS"
  }
}

resource "aws_efs_file_system_policy" "efs_policy" {
  
  depends_on = [ aws_efs_file_system.myefsvol ]
  
  file_system_id = aws_efs_file_system.myefsvol.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "efs-storage-read-write-permission-Policy01",
    "Statement": [
        {
            "Sid": "efs-statement-permission01",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Resource": "${aws_efs_file_system.myefsvol.arn}",
            "Action": [
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite",
                "elasticfilesystem:ClientRootAccess"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "true"
                }
            }
        }
    ]
}
POLICY
}


resource "aws_efs_mount_target" "efsmount" {

  
  depends_on = [
     aws_route_table_association.rt_association, aws_security_group.mywebsg, aws_efs_file_system.myefsvol
  ]
  
  file_system_id = aws_efs_file_system.myefsvol.id
  subnet_id      = aws_subnet.publicsubnet.id
  security_groups = [ aws_security_group.mywebsg.id ]
}