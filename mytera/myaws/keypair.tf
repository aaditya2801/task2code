variable "my_kp_filename" {}
variable "my_kp_keyname" {}

# Creating key
resource "tls_private_key" "private_key" {
  algorithm   = "RSA"
}

# Saving to local system 
resource "local_file" "save_key" {
    depends_on = [ tls_private_key.private_key]
    content   = tls_private_key.private_key.private_key_pem
    filename  = var.my_kp_filename
}

# sending public key to aws 
resource "aws_key_pair" "public_key" {
    depends_on = [local_file.save_key]
    key_name = var.my_kp_keyname
    public_key = tls_private_key.private_key.public_key_openssh
}
