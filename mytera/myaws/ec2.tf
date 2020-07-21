variable "my_ec2_ami" {}
variable "my_ec2_instancetype" {}
variable "my_ec2_type" {}
variable "my_ec2_user" {}

resource "aws_instance" "myos" {

    depends_on=[
        aws_security_group.mywebsg,tls_private_key.private_key
    ]

    ami= var.my_ec2_ami
    instance_type= var.my_ec2_instancetype
    key_name= var.my_kp_keyname
    subnet_id= aws_subnet.publicsubnet.id
    vpc_security_group_ids = [ aws_security_group.mywebsg.id ]
    
    connection{
        type= var.my_ec2_type
        user= var.my_ec2_user
        private_key= tls_private_key.private_key.private_key_pem
        host= aws_instance.myos.public_ip
    }
    provisioner "remote-exec"{
        inline=["sudo yum install httpd git php amazon-efs-utils nfs-utils -y",
                "sudo systemctl restart httpd",
                "sudo systemctl enable httpd"]
    }
tags = {
      Name = "mywebos1"
  }
}
resource "null_resource" "efs_attach"{
    depends_on = [ aws_efs_mount_target.efsmount ]
    connection{
            type= var.my_ec2_type
            user= var.my_ec2_user
            private_key= tls_private_key.private_key.private_key_pem
            host= aws_instance.myos.public_ip
    }        
    provisioner "remote-exec"{        
            inline=[  "sudo yum install git httpd php nfs-utils -y",
                      "sudo systemctl start httpd",
                      "sudo systemctl enable httpd",
                      "sudo mount ${aws_efs_file_system.myefsvol.dns_name}:/ /var/www/html/",
                      "sudo git clone https://github.com/aaditya2801/terraformjob1.git /var/www/html/"]
    }
}