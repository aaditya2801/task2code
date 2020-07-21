provider "aws" {
  version = "~> 2.7"
  region  = "ap-south-1"
  profile = "default"
}

module "mytestmodule1" {
  source = "./myaws"
  my_vpc_cidr = var.vpc_cidr
  my_subnet_cidr = var.subnet_cidr
  my_datacentre = var.az_subnet
  my_rt_cidr = var.rt_cidr
  my_sg_cidr = var.sg_cidr 
  my_sg_protocol = var.sg_protocol
  my_efs_token = var.efs_token 
  my_efs_encryption = var.efs_encryption
  my_kp_filename = var.kp_filename 
  my_kp_keyname = var.kp_keyname 
  my_ec2_ami = var.ec2_ami 
  my_ec2_instancetype = var.ec2_instancetype 
  my_ec2_type = var.ec2_type 
  my_ec2_user = var.ec2_user
  my_s3_key = var.s3_key
  my_s3_source = var.s3_source 
  my_s3_acl = var.s3_acl 
  my_s3_bucketname = var.s3_bucketname
  my_s3_origin_id = var.s3_origin_id 
}


