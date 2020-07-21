variable "vpc_cidr" {
    default = "192.168.0.0/16"
}
variable "subnet_cidr" {
    default = "192.168.0.0/24"
}
variable "az_subnet" {
    default = "ap-south-1a"
}
variable "rt_cidr" {
    default = "0.0.0.0/0"
}
variable "sg_cidr" {
    default = "0.0.0.0/0"
}
variable "sg_protocol" {
    default = "tcp"
}
variable "efs_token" {
    default = "my-product"
}
variable "efs_encryption" {
    default = "true"
}
variable "kp_filename" {
    default = "my_key.pem"
}
variable "kp_keyname" {
    default = "mykey"
}
variable "ec2_ami" {
    default = "ami-0732b62d310b80e97"
}
variable "ec2_instancetype" {
    default = "t2.micro"
}
variable "ec2_type" {
    default = "ssh"
}
variable "ec2_user" {
    default = "ec2-user"
}
variable "s3_bucketname" {
    default = "mynewbucketforjob1"
}
variable "s3_acl" {
    default = "public-read"
}
variable "s3_key" {
    default = "snapcode.png"
}
variable "s3_source" {
    default = "C:/Users/aadit/OneDrive/Desktop/snapcode.png"
}
variable "s3_origin_id" {
    default = "local.s3_origin_id"
}



