// Changing the html code and adding the image url in that.

resource "null_resource" "addingurl"  {
depends_on = [
    aws_cloudfront_distribution.CloudFrontAccess,
  ]
connection {
    type     = var.my_ec2_type
    user     = var.my_ec2_user
    private_key = tls_private_key.private_key.private_key_pem
    host     = aws_instance.myos.public_ip
  }
  provisioner "remote-exec" {
    inline = [
	"echo '<img src='https://${aws_cloudfront_distribution.CloudFrontAccess.domain_name}/snapcode.png' width='300' height='330'>' | sudo tee -a /var/www/html/index.html"
    ]
  }
}

// deploying webapp :

resource "null_resource" "deploywebapp"  {
depends_on = [
     null_resource.addingurl,
  ]

	provisioner "local-exec" {
	    command = "start chrome  ${aws_instance.myos.public_ip}/index.html"
  	}
}
